Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B632D0CF
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492523; cv=none; b=QU2T598tZ6USZGwrSc+/RcQitLBGl7FNX8GBDjiAjj8BBJp6eRrJ+WKowTMqNyYDSBgQOGSJQjIex/YglOCIG8d3OI1OCdQo7Ugy3YivjA8/RHD50V8WLKX77rYjz8Pj9gdJ3cBsb+/JcAiP1c1GQEI06kRtOV3TlGbErTN5vQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492523; c=relaxed/simple;
	bh=k4bJN+sANdPTHhzkbHsdq35Ia++T8NYNoHxo79kCHIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANZ78Yj6zH19GQmJizsfSVzl+OiT4DBeK9KQ0VyD8LePG4UvRu+1Ha9QTbY5SMLXorIyDya+Qw0gALwK8lPdi0e9bRS3NxcezRXdIwwOpT0om6/3fz1l7h+dlxnAmofoATA4f484SRvhRHCwPUPGW5CSrrKh48vh0QGxFs0TeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9hfgTcs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9hfgTcs"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b790af67so886908f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772492520; x=1773097320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5DizpqoyEuazrKiB5I9gJ8LWKHFRH/lYPzCykAHu10=;
        b=N9hfgTcsGsPO5KhSKspMVRP1I2xnUOdtPJlMJY79mFyFuf9NgrSRA81z2wVhEGzPGC
         AuzZsuePY/Rt/815kzUQGYmHkeaECa4cN0TRcrlcpneQOLa7VC4ZGBgqHeJeqDITM03v
         PqA2we9l529oNtkJrIcaAjxLCreud7I1vQsYU9zMzCHnuZWwDPAjAHeiuY3HkGwKiIc/
         ZEw5bUe6ZfLJkUnwGvvHZtNqsU6FD/gqbi5Yj9obBKWWW6aUaR64s0ZB8/wh7iD6b51/
         a1K2OYkhkch/duYF+0SjZeIbpqaEJ3RmL711LO8Y13UnlyMTOiNfC8VvdEK7V6sK12Li
         /2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772492520; x=1773097320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5DizpqoyEuazrKiB5I9gJ8LWKHFRH/lYPzCykAHu10=;
        b=hU+YVk4DP/AtGRELO+e4LgFKg43PXWXlmLsAY0mv+yslBDJURjIe74hsnvXQc0weG2
         jiMi1aLSaCc1ManuO+KR0kA9fozToI4duD1vL6DZk9ccXNDRvA1oTrUUpfT/oYkgR2/O
         K3MTmXP08csGL60SKBF+F/K9PhPiQVFxA/8+u50nc9K4AeWzaik4bAKymuqYQzMphYRj
         TuwffrjrFGsxI+nJg4BvZ+uB0igFrgE80YFoN0rhGatJJDqVB0KD1ymC8HoODeV+yeks
         8wfbDNLNCDW5I2ov0fqqbhWvSP2wnh5tfpr8wWwYZ9lT2betsrwRBkSiCEoE6TRNip3u
         6aYg==
X-Gm-Message-State: AOJu0YwsTtVIC5hJVVfM3gsX/hyczJa8jHSGlxBn/lwEyySsB2QZYEkx
	ajCuT7KUtMeoMLgE78pzHDQebAObKRJOkJ9uil4z+Doev6BruCkuMB/6o3RLxVkZ
X-Gm-Gg: ATEYQzywQ+XU4m9kPpm8IrzsyhfC4gwqIHgiBUX12vqjtQqqAAqmfxqVdwzbTVkCUAM
	ARQJSctct+Fyaus/cTSgDhZ7VFpqSc7yPmulIsAA0RlWVffuBwlF8Mo3e1BDJQA62u8R32wmEcl
	VxoG/xTgQR5TAqG4ujOsk3IiUScIM1ILFzpiMajJCh3Nb9MWULxhzDsMoyWot/y9FFEFXH9CzDn
	V3iuPotrQZDoJAUojNSvhtIYMkJhWiVenwcgI7CxlAqSmMucEYYy6iwNYvxARTSz6WLdp1W66KB
	QSgdm4D2f9vGpE28Xw2EmFTO0McqXtncuLHqteAnxmIiMkgKLLoFVbqb2N1pM/Fd3m1XQuNMQ5X
	lYxYIIJiWwBunhYgKqOHvMuVVdAuzUcMqyo7HEzokXmkkcOyo5KDoHve/6q2GMr5gd/td5Tnpkr
	PTsHlq6dqn2S02xihKpjoz
X-Received: by 2002:a05:6000:2401:b0:439:9464:ac0a with SMTP id ffacd0b85a97d-439c10a0881mr146496f8f.10.1772492519718;
        Mon, 02 Mar 2026 15:01:59 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:36::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm9155711f8f.4.2026.03.02.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:01:59 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [net-next V4 2/5] net: ethtool: Update doc for tunable
Date: Mon,  2 Mar 2026 15:01:46 -0800
Message-ID: <20260302230149.1580195-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.

Highlight that the knob can formally be used to configure timeout
value for pause storm prevention mechanism. The update to the ethtool
man page will follow afterwards.

Link: https://lore.kernel.org/aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..1cdfb8341df2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.47.3

