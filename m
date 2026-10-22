Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709834;
	b=4t6uREYJ5PvOFxH6qu7aqsenp7/UxjX7Cqg2rUuqntFPDSABChJMPGtIiniI7fq+Bt01
	 WJxGm/x+r9MHW6hEDz0mNtJ82XzTeV1i0NjZHIv0SRxGUcxtQNtiKYWKS2DPXG71hiIaC
	 ogoE5H4v1zHZOX/9suQMUWBlXGVDYsfN/Zzy1xlF/cAiaT1KunybOdrQ4EO8iuwU3r6L8
	 8CRZUfIysWi3VON0AOGBLL2bPHRtNUYgVQIord1j66BQnsuDgLeOYg63UorzvQPo+0j6o
	 nxa3djxGg0+HE5b4RbxZUd14pQOsOjKNs6FUbibo1wS9RnDeVpNV8Jbwlc0b2Z9al5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709834;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=z9FAKVdyeVMvleoyzIAnMj2py3FpKl2sDcMqYrZVJ2Q=;
	b=tRx8PtNvPvVNsEkkjI83HXeGn6ptJmP+5LG6NfFYg0hrB2B8ItsUx0H4jdYTximTIduy
	 qQBKJ0Ulc50M34bwTRFt6CLddFBo+mTYGWtK/taWwbY5jH5Rg6w9VvPlkvHzbaTkRWhdX
	 gele9uAIAAhUjOt31KERnGkClhDt4lfRpFXsLLymcZNXR4JBIs9fXs2J/CQWCZHmq9SmV
	 dvyQLxvpug0vVVmejVPC9WuDOzu+MlPm8vb+McJJlpf4N95Nu1h3q45aqtA5W/ZgieAn7
	 /9SWHeKLMmn3Ovi54I+lg9j+v9KDPzOoHTxWWGmx/et2him/r/dFKfXbP2Y713MhXJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KJtAyG90;
	arc=none smtp.remote-ip=209.85.128.225
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0B606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF0B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KJtAyG90
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-8ab38a051aaso3781787b3.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709833; x=1793314633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z9FAKVdyeVMvleoyzIAnMj2py3FpKl2sDcMqYrZVJ2Q=;
        b=m0tz9mlo6wek6Cw8Igwr8O8QhbGGW/U1/0pzMf2IDxYeA6StzyPa96Pet1fEjLNEaB
         hBhMQlsDcCU2sEysCx8DU3RH8vgasGjX0c7hsnVej/8lZtQ9+QSeNdgMTUYL83n7hnHy
         Xdr19xY+Kau5TZUds31Rr9eDKUaWQLJnuxnxf/x+alQWRf8dP6KA7y5LPCS6Vpy5XErB
         /h/j7XbFyaymsmtfSIXxx/Q7RCr+hJJWv4cpQYnmjThDrU9VdXbkmIVJMksuukq9iDTS
         jhkurC7C5WDgux4M2b2I15bT8nNBQUmjeTtSW+VASjA24lLZ5w3jZoR9sGckj26VjjBm
         2Vsw==
X-Gm-Message-State: AFq9FYJELShFj7hatRnmKdAy2zO/dkjnC6ly2dO6PsO9AMzLNGiVauz2
	SadtV5X/X94dTUNvd+8V/Y6AmlKCaSVMgChU8uiRrU4kzu5aR7NpYM+Il33qyWIp504qznLgJkA
	ial6VRVhh4ESjmzuvcTct/lbEiznHYeJT9pmSxs/CnBDk+8FmEKMVz6b4d+Cd38qMf4QphVoEJS
	yHo17XW2S1zKE5/oNBOsnefTUevcvDkPf7n9cR3hqFzxhHyolFIihHXbWM9AGjbmdd+QDXTy+gf
	gDBbB7AbaSLiEoP
X-Gm-Gg: AYBFou08Hhwo/qKWczo7JvzR8vBpuQxkN6eOUCeCSzDHALr2zMJkMqNp3/1rIXQLnD4
	lmVXNHUhWTBCMpEvpL/vun/Yqti9MnQlxeRc6Cn22EvMtBcLkYRkZhtoHOD/ByIOmAKQjbI8A4s
	3sgdeL2fKlc3ckqKNiVOe24opXvoaFdlukBb/0ZHwch3PMVw6u8lLyCqGRoTp/WUmH/Wd/3cqAZ
	WU4zfdFedXZPqds1piJfnLJ2B5nLSoQGhVDPMBz9PKHI28F/GgpiQ2AJnJsLFeGODltz2Wwe+2I
	j5KrvuiYDkdIHywBeYO3LaqAX1B75Q+x/Tn8Zqk62hpD6A0F/amw7jQPmkkTVXUQ/Z6Y4is4OlL
	QTR6knxLdQcojoxDUZjvtCg1p7jRUO7bxWGNVr9WyvXxD9Rc6n+2eia/Z7nqFZoF+JK48sJXy7f
	vYse2bIbcC2B/jJvVfflVq4WfQ5vae/pSDrUNfFDyMupU=
X-Received: by 2002:a05:690c:660c:b0:88f:ccf7:25d9 with SMTP id 00721157ae682-8b157dd50a6mr3802637b3.60.1792709832964;
        Thu, 22 Oct 2026 15:57:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b1560532f2sm88317b3.35.2026.10.22.15.57.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:57:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b92acedd9so10210526d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792709832; x=1793314632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z9FAKVdyeVMvleoyzIAnMj2py3FpKl2sDcMqYrZVJ2Q=;
        b=KJtAyG90EAcRaGeVcmkcHFGLAW1z0bB/mqhYPtQHNOi/Lvjk0QxWP3MNGbSmtqw3Rp
         SUsAnZtjwkhQNbRLl4j+oiNywRtWhA8LKLvwrdHBrnyqDS4mEXhDFgR4zlc+PyKYLLBS
         5IiaEOKBkNEcMMepaBtbDcL1THuOgQV3bpj8w=
X-Received: by 2002:a05:6214:300c:b0:919:89f4:64d9 with SMTP id 6a1803df08f44-91c3ab0a6c5mr3600816d6.22.1792709832236;
        Thu, 22 Oct 2026 15:57:12 -0700 (PDT)
X-Received: by 2002:a05:6214:300c:b0:919:89f4:64d9 with SMTP id 6a1803df08f44-91c3ab0a6c5mr3600576d6.22.1792709831759;
        Thu, 22 Oct 2026 15:57:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c395025d0sm4501656d6.5.2026.10.22.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:57:11 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 0/6 RESEND] net: dsa: b53: PCS fixes
Date: Thu, 22 Oct 2026 15:56:50 -0700
Message-ID: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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

This patch series fixes a number of issues found with a LLM and while
testing on a Broadcom Northstar Plus reference board (BCM958625HR) using
a SFP connected to a fiber converter:

- there was no serialization of the registers across multiple lanes
- the SerDes powering down was incorrectly managed and should have used
  .pcs_{enable,disable}
- the interfaces advertisement should have been confined to successfully
  initialized PCSes
- the negotation and forced link parameters were incorrectly supported
  and should have used pcs_link_up and pcs_inband_caps
- link state should have been reported through the PCS

With these patches disconnecting the fiber cables triggers a link down,
as does disconnecting the fiber converter from its cable or powering it
down, ip link up/down also work properly as a result as well.

Florian Fainelli (6):
  net: dsa: b53: serialize SerDes register transactions
  net: dsa: b53: manage SerDes power through the PCS callbacks
  net: dsa: b53: constrain SerDes interfaces to initialized PCSes
  net: dsa: b53: configure PCS negotiation and forced link parameters
  net: dsa: b53: report link state through the PCS
  net: dsa: b53: apply resolved link settings to serial port MACs

 drivers/net/dsa/b53/b53_common.c |  69 ++----
 drivers/net/dsa/b53/b53_priv.h   |   4 -
 drivers/net/dsa/b53/b53_serdes.c | 407 +++++++++++++++++++++++--------
 drivers/net/dsa/b53/b53_serdes.h |  13 +-
 drivers/net/dsa/b53/b53_srab.c   |  12 +-
 5 files changed, 345 insertions(+), 160 deletions(-)

-- 
2.53.0

