Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BA390CB2;
	Sun, 19 Jul 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470993; cv=none; b=puUCCyWcXARiO3Un7eHoQn/bn6Skq2LWrlPmrPdKqxx+TjNdEsElOviNL5fT8Fw3bqP+aBt1kKT4PBOMVFfS6tGZnB1QKWFA0vw+e/tunI55jXZ2YmQNmZ/OlZgZofXY19+zG8EXQijatbXik9WJEoIZAThTtmt0gqA33/KOuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470993; c=relaxed/simple;
	bh=UexbzcizlZLoa0y8/PlTbgz2dI/u5nx5atqlkzE58cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RX/2ka3o7vRUAe2N5EpkkFM1DMGIrp8G0j6XMreOck++infUx2TYT/B+LVnIud8gdwLpCU2UYTvZgY4ssrjAoqIhoIJdCbcwaSvNLof90u+r1yIyX/t8j67+Z6uPWaP3fRh0GTwjfwoeIuf/Bx2/Lr3gPwF1nY2avFiapiyWxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-14 [87.215.145.39])
	by mta-10.privateemail.com (Postfix) with ESMTPA id 4h35TN4Scvz3hhTC;
	Sun, 19 Jul 2026 10:22:48 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH net-next v2 2/2] nfc: s3fwrn5: support the S3NRN4V variant
Date: Sun, 19 Jul 2026 16:22:41 +0200
Message-ID: <20260719142241.12640-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <18c3e13f-88e4-458e-9f57-7aceeb1ce1d1@ixit.cz>
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net> <20260705190621.128257-3-jorijnvdgraaf@catcrafts.net> <18c3e13f-88e4-458e-9f57-7aceeb1ce1d1@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello David,

Thank you for the review!

On 19/07/2026 15:15, David Heidelberg wrote:
> Please, send the "drop the of_match_ptr()/__maybe_unused annotations
> from it." type of change as part of the series, but as a separate
> commit before the new HW support introduction.

Will do in v3.

> Since you touch S3FWRN5_I2C_DRIVER_NAME, replace define
> S3FWRN5_I2C_DRIVER_NAME occurenced with the "s3fwrn5_i2c" directly
> before introducing the support (also separate commit)

Will do, also in v3.

> is S3NRN4V really a variant of S3FWRN5 or is it just S3NRN4V?

It is a separate, later part, but from the same Samsung S.LSI NFC
controller line this driver covers. Samsung's downstream stack drives
that whole line with one kernel driver and one HAL: the HAL's product
table lists the N5 (S3FWRN5) and N82 (S3FWRN82) generations next to
RN4V (S3NRN4V) and others, dispatching on a product code reported by
the chip's bootloader, and the parts share the I2C framing, the
power-control GPIO scheme and the proprietary-NCI style of
configuration. The generational differences (bootloader protocol,
RF-register transport command, FW_CFG payload form) are exactly what
this patch dispatches on -- the same way the driver already supports
the S3FWRN82 next to the S3FWRN5.

That said, "S3FWRN5-family" can indeed be read as "a variant of the
S3FWRN5 chip", which it is not, so I'll reword it in v3 to something
like "a later part of the same Samsung NFC controller line". The
phrase also sits in the commit message of the already-acked binding
patch; I'll tweak it there too (commit message only) and note it in
the changelog.

> While it's "register update" and function is named "configure_dual",
> it's loading firmware.
>
> If it's not a firmware, but only configuration, it can reside inside
> the driver, maybe LLM even be able to decode to understandable
> sequence of registers and values.

There are two separate things here: the chip's executable firmware
(~180 KiB) ships in its flash and is not touched by this patch at all
-- its download protocol is not implemented, which is why the
download step is skipped. What is loaded here are only the two RF
register tables (~3.5 KiB combined).

Those tables are configuration by nature, but I don't think they can
reside in the driver:

- They are board-specific analog/RF tuning, not chip constants: the
  values match a particular antenna/matching-network design, and the
  vendor revises them across software releases (my two Fairphone 6
  units shipped different builds of these files, with different
  version stamps embedded). A different S3NRN4V board design would be
  expected to ship its own tables. Per-device data loaded at runtime
  is what request_firmware() is there for, much like Wi-Fi
  board/calibration files. The tables ship in the device's vendor
  image, which is where I extracted them from.

- There is nothing to decode them against. The register map of these
  controllers is not publicly documented, and even Samsung's own
  (Apache-licensed) HAL treats the register content as opaque: the
  only part of the image it interprets is a 16-byte metadata trailer
  at its end (version stamps, used to decide whether an update is
  needed at all, plus a region code), while the register content
  itself is pushed to the chip untouched, in 252-byte sections.
  Nothing in the stream or in the vendor stack identifies
  address/value pairs one could transcribe, so "decoded" into the
  driver this could only become a 3.5 KiB hex array in C, and we
  would lose the ability to ship a newer table without rebuilding
  the kernel.

- It also mirrors what this driver already does for the parts it
  supports: s3fwrn5_nci_rf_configure() loads the same class of table
  (sec_s3fwrn5_rfreg.bin) with request_firmware() and pushes it via
  the older START/SET/STOP_RFREG commands. The new function is the
  same operation over the newer parts' transport command.

If the naming reads confusingly I'm happy to rename the function or
extend its comment to spell out the firmware-vs-register-table
distinction.

> For next revision of the patch, I'll likely still have some
> additional feedback.

Understood -- I'll send the v3 with all of the above shortly.

> With next revision send also as last patch the device-tree entry for
> the Fairphone 6, so we can also get additional testing from
> developers/users.

Will do -- v3 will carry the Fairphone 6 DT patch at the end of the
series, marked as included for testing and presumably to be picked up
via the Qualcomm DT tree once the driver side is settled; I'll Cc
linux-arm-msm and the qcom maintainers on that patch.

Thanks again,
Jorijn
