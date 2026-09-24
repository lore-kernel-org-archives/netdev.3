Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C286409298
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291558; cv=none; b=ZAZTWMWViUtaOvsKUHKRY9JhAXykqvb6ehT5OvhC/Ff2hZXrEZEuV+BQ69CE61yJbwv9BB3xglHSoKX44xPE1o+YPr66NNu9j4GY3ytN6Tx0auUIzjaSrLCGEmPtBpHUc4yERmsQg00vZnKbqlcvzZEaIk9ltmYQYKKhgOK1UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291558; c=relaxed/simple;
	bh=k4W4JJAJ+/wMGhiFeBbjA2DrPe4ndPz4PiSAhGwbu7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGmYhYtvcCgfIJ4pcinxKxVIsxYvxMrRS7is5Y8/BT8mj3cCq5KV7rP5ZLcRAW07iZw7852q3fTIqFg9V/GuFpeyEgyXxSvR3z5hHO34fgqlAaCuK/03vZApA8luprbyzYa41PQsf+bBrly3ZkxH6rSrdIPz+q01MIvk67XOB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rao2w013; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rao2w013"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2D01F00893;
	Thu, 24 Sep 2026 23:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790291557;
	bh=Zoh9IKVhcgBLUfmCDki2bf/zsCsA3fkt1vX4yfAL1d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rao2w013db7k6NfXXlMLCSt0bHp80AyEfH6CRl/62kLHyqChWRVc2Q8F82j0036bL
	 39VNWpoddrB4KlFhMeTqfTXLiY2636F/u5A0spHs3D4/4VO8wDBWNwnG2gKfywIhTs
	 MnpKSJ5VmFQNGp8MSP0brvgSn2CNWPUU9pLzkoo1Zc+KJCvI9P/ReKLU6KSnMmwhIw
	 L20wy5IYYysksAWVVACF+9TVzN7QUuxBMn/CnOVCRBToB2A8ggkl/pFVYZM1cENtEZ
	 JY9XdESRtz4aZfPIAq8lfp/C3ODWxPaihCIdj3Z41Zs7dYvtJ5gOnB4ouxgPpjJBN/
	 QAiz2J28+vkaw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] dpll: do not truncate the requested pin frequency before checking it
Date: Thu, 24 Sep 2026 16:12:09 -0700
Message-ID: <20260924231211.568213-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924231211.568213-1-kuba@kernel.org>
References: <20260924231211.568213-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPLL_A_PIN_FREQUENCY is a u64 on the wire and dpll_pin_freq_set() keeps it
as one, but dpll_pin_is_freq_supported() takes a u32 while the ranges it
compares against are u64. The supported-frequency check therefore only
looks at the low 32 bits, and the full value is what reaches the driver.

Nothing is hitting this today. Reaching it at all needs a pin-set above
U32_MAX, which no sane caller sends, and the outcome is mild: a pin
advertising 10 kHz accepts 0x1_0000_2710, ice narrows it straight back to
10 kHz in ice_dpll_pin_freq_set(), so the hardware still ends up on an
advertised frequency and only the "frequency is not supported by the
device" rejection goes missing. The other direction - a legitimate request
above U32_MAX wrapping out of the pin's range - needs a driver advertising
such a range, and none does; zl3073x_pin_check_freq() refuses one outright.

So this is types rather than a live bug. Widen the check to match the
attribute, the ranges and the driver callback instead of adding a U32_MAX
rejection, so that the second case stays right if such a driver appears.
dpll_pin_esync_set() already keeps u64 throughout its equivalent loop.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/dpll/dpll_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index fb24fd53f2e1..e5380d95f238 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -608,7 +608,7 @@ dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
 	return -EMSGSIZE;
 }
 
-static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
+static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u64 freq)
 {
 	int fs;
 
-- 
2.55.0

