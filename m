Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627270;
	b=0LpUh79P9jP5LWC7OU9XBzRRX0pB4t3Q5EJjMhYFqoO1U16e0iPDLaaR0LFrc+Ow8coY
	 L0r9oeLJAARi1dXILqxjk4oMBP2oe3MxMsp9DhDjNTtAxnEjbdRREBKi1dLsAOVCAisrX
	 w6eH//sdBCdwnGf21Ec9h1YKycvVXD+ztafPXN3eJt6tghVHQrYhYLdwkBlBX6eHBOF4B
	 Oe6VbUrE6ZY61BkFucAgyAueKjxp9qGdeU15rmI4+iUkbezWC7D+p7B2QUzxcxye1rLGm
	 UTv7TPpN7S6aSBdQalnt8lm5KHkXRtL++SyzqxZEXDSFEI3KAoNFntIq/Pg9XVlcS9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627270;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ddgPaijUvIbheBZatU1W8+gATV3/IFQSBsN9yaAotzY=;
	b=JkCKodPVuQYjJnDEELxF41JuSeUKAv3+PxQeuCkE0RAE6cKbLVVitlTVq4AwqPPim1Ft
	 naQ4PlO12i88Yeab7H/NaiidODDvO6eWSzt6oikr87nA16LnvyJ+Y5pbiMHSznBLXUF52
	 Fcoij7PJAElp7wt69AgR0vrVRW0YSD3RSNfHCr+FLSaoDtvyU/fy9NhhGRCC2vlYIl2as
	 AzbDuYbXkJSTZ4Pxd7snr5LJVOzYlmVE2Ng/EVvmPgZ7GHEH9+TTm1xEcv8Tu8bhV2O2a
	 n/bZ2ZXkYXoY1ifYeubcGUnjNKr1+poh0Hm/JwlScCJI2lsxPO3rWIlTfzwoPUfPMmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FsqjNyMf;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0A606A32D
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 03:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D0A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FsqjNyMf
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cddc597d062so1340447a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627270; x=1795232070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddgPaijUvIbheBZatU1W8+gATV3/IFQSBsN9yaAotzY=;
        b=np9pni8WejOvsiNzhB3puhJwHEcPkGruSzrd/NVatZhIORq+LVdbeKdYVktFomT5XS
         H4EU3Tabm8+8r8V/x5EWrpfH/Y7QDCM+1BOPNQGuklZWAwc13NgXjd5aGH1ZN+bbEIfg
         AzELUBrAH+asgUPhyVcjunaDMw9N+DFR6/IIVVrGoovGpLSjZvaPqOhzVWyvJTQx+Vzc
         6G7D8dIsh1XiYhvTAxjPc7Fuqw9le5t+jotzJq3BGkTH6VwmQkVIn7Huags3BG9wqCdp
         pOPUDyV+jXuoWV0OWFVfeya/Uu/JaRBpqrPJa4YIuC4XiPIGFbqxMpEp62d/af0SZRIk
         onMg==
X-Forwarded-Encrypted: i=1; AL+hErGG86OPyXLunuFMVBaYA0UWMAuAbF/BqXrUyISF7tQHK1HpPdJhjl7mmHdTKTvumSjZCGiRWmI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C9OMLmocCVYJz+SuOKtdqV1VZ6LaZSfPS88TpRhqK1uOPZWrO
	lOttNy3LbenixiJZYR9ToAQpzBRxweton5djigB4aW/uXR2ql7RRjZ91bvWfZxNEWiiTBH9pgw2
	o2xDd6QT4n8f8007bKAbitXneGjv9UlqNx2zrxGcLNrje0mCrE7Ol+m5kmM8PpJ8QAhDVpRRqwG
	HCW/uwqO+DHW9LWwzc121IxKGHYN25L63+2+I+lJvilCQsp7Bed12NrknkrLDud5AnFhB6lArTO
	xX8Qk/cWuE2FkrH
X-Gm-Gg: AYBFou3f9uLjI5aPTOcyJbEoIZu/SlCOQ5W0WUZyU4YH2n4qkPL8VF85dvT1Y6uUbDZ
	Z4HqBzFI1r9cTKhq6TqWn6qbiYmSMm9ocUGGmFd8VIB+vp6BefQMbu5dGRi3rHwzg5vXlpSM0M2
	DhvwZuxVVtTQhn0o4lY3PDPRkTaiTKyD31I8tc7GXhSfQSPk33N6i47tixulwEsL4HHl9DEdEXW
	MQC9bcA+/ORJx4AOUA2x/B6dp3pLL4W/UH2gdpeZt9MZQSFdiHb+n9YcpwnyMsq1ktNvBTBUSst
	h4Gki5CkpNKKllVPGQ8zpp6OqwrMtVUX+91uE/sOK/dkx6jepKoEV2iMqXJI+JP3EES1tO/v4FT
	5XE+CxSb4L3jiKJ10OqOnGwjR/tHbNxpeO3ONkm+qB9973ZMrVaCCSyKofNoo4QOpGUw/1Bpidi
	Ew1ft1BAlXcegEvFB55wNyZj4/0tUNFe7uqdX/qQl3
X-Received: by 2002:a17:90b:17ca:b0:3b1:fad:b1bc with SMTP id 98e67ed59e1d1-3b1b0d77ad2mr4566989a91.63.1794627269656;
        Fri, 13 Nov 2026 19:34:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1d1d744e2sm181906a91.1.2026.11.13.19.34.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 19:34:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d1353fdcdso7021728eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794627268; x=1795232068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddgPaijUvIbheBZatU1W8+gATV3/IFQSBsN9yaAotzY=;
        b=FsqjNyMfYgeS4j2kNrm/zfVVwKD8gp6v3yQOf5DVh7CEU0zFvg6tiYf8uA+setgmAo
         J7xTH3iu1L9zPuzHHGjVEHcV20AoHjk/tS0Kcpmel0PAmHFTmFlVzj2B2J6+1m5LVU9w
         EbEkdeU+675PubUrj3KbEAmaTvpfBvl6GU3S8=
X-Forwarded-Encrypted: i=1; AL+hErGARnPOVH8EnrNA/ZuFDj38q86HLKZLyQf3Rc7wACKdNIRJH35zEx/BlSL5MajJhpKilVzu/Jg=@vger.kernel.org
X-Received: by 2002:a05:7300:269b:b0:37a:cafa:6d78 with SMTP id 5a478bee46e88-37acafac54amr1253744eec.33.1794627268020;
        Fri, 13 Nov 2026 19:34:28 -0800 (PST)
X-Received: by 2002:a05:7300:269b:b0:37a:cafa:6d78 with SMTP id 5a478bee46e88-37acafac54amr1253710eec.33.1794627267158;
        Fri, 13 Nov 2026 19:34:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm12865283eec.28.2026.11.13.19.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:34:26 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Phil Elwell <phil@raspberrypi.com>,
	netdev@vger.kernel.org,
	James Clark <jjc@jclark.com>
Subject: Re: [PATCH 3/3] ARM: dts: bcm2711: give the GENET MDIO controller its clock
Date: Fri, 13 Nov 2026 19:34:25 -0800
Message-ID: <20261114033425.876398-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-3-a1728724d0f8@tipi-net.de>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de> <20261020-devel-bcm2711-gisb-clk-v1-3-a1728724d0f8@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 20 Oct 2026 16:58:11 +0200, Nicolai Buchwitz <nb@tipi-net.de> wrote:
> The MDC of the GENET MDIO controller comes from the GISB clock.
> Describe it, so mdio-bcm-unimac can get the real 200 MHz from
> clk_get_rate() instead of assuming the 250 MHz of the STB chips, and
> can put bounds on when an MDIO write completes for PTP.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
