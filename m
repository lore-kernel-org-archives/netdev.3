Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A181B4138
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835899; cv=pass; b=KVhoo0Z3bZ7kn+JZh+LxXinPl8xZzYq/K+lHluYc0447deBJiWBNHzPZMAIJ+qV7S7IKb1y7WdXqIdw3K0UqmI9bs5U435TPF0P87ln0qBsuIp0Pv6bJIKE+f+J069uL4lGuisuEk75HuGDC9k+B+2k0fFBohpbS26Yr+Ja1vpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835899; c=relaxed/simple;
	bh=I42Ohy9yZwsyID01fCH/7PvGfx8whcB2WSy7Cl1XPC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0ZPrRRtkzVBMPnZWGjcTf57tosFoMO1pMKmKYqzcDWcdIIpD/2gi5h4Okigriw3j2gJOYdBIkHM2fPIB8XrxHLDrKTWfR8wLkUeSg+zwLPl/Q6Ngg0j77dBqB1HwFY9ChA/ERkPZgbyVyxe3CrwoEWEWsjgkMAu6xFCmNgmn1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/TXHoA5; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/TXHoA5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso3328730a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 19:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788835898; cv=none;
        d=google.com; s=arc-20260327;
        b=Da35cjJdwh0bciPCRqll+Z1mVZycfPy9KjYWq7bCAmFcMxK6FzGLWtVyzsiK0W/ZrF
         NDA63beAzz5O6LczAp6NwFvltdJZoDATYc6FxZhW4GZyEN322wFsQoYLFHWSnq6XazlK
         qsmSM4OCK6Q/2JMUUD4DfzOUFR9JsEpmtpuXen6KzU4WcjHuCetuk8x9O8WiRMZCODSZ
         VytEMVdIQjkTT59qVyQ1zpB+BoiOCitHzVdyVn5vb8MV3FOgSKmuQsP06JXO2yKEkPwV
         d/Llx88jXsbk3GzhFhOMlBhMr3sJIbMuX0ZKm64BNeFKM6a4ahtozTekLa3NZKEU56Fy
         6kQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MKmONGyZLE0mSFol5WqnN+Rq5dtwnD7RFNzUtmGhC/w=;
        fh=OiCzhxUHuo17TlR80aSY6TTGGQKGa2/FTP1VlhnVXPQ=;
        b=KFoBwrX6aVZfo17Bsjk2ym7cVyZAs3zy+pBDVNiGaSuWvLHSPxKFPBNxvZemWo6bdT
         E6wC0zK6HF7tnPmSORjYP+Ya7OLAEwKgIChGDO6uykOOOMgwWY6GG0xddpxlRbubxDnv
         0p8KyusJ5USpYI3BAJS8zaXyDc8yA/OoBkGDeO94qTNEMIu3ye/8JEbsOQzt3YuJ0X9l
         efjeb/q+nO1rFqB8Rrv4S3yxJzBWF1eNklHGA8u5uc2qOp40/v2FoksNDiADI4OIpHxn
         X20F25qJdFshKbG/ohDKNJq7E23cK2urESw8ClEop/bstn340ezDAsRsi1ztdHydGVVS
         D4jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788835898; x=1789440698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MKmONGyZLE0mSFol5WqnN+Rq5dtwnD7RFNzUtmGhC/w=;
        b=Z/TXHoA5sMUp3mp3qgVpHkUVJdkDkyn/Zvek0DuhAkNtsN0UZWJBJZPOxxZo/aWPWX
         Th4dHfONRkEphFviyKQ/knXp8ExNjmjPCPVn49T1cpa7xC5ztIagedMBzJ23iFMc1IFB
         2OK/iuAwpbe9c94MjlTH0XT2It14qaTPrgIqpgYXQfVhOc/R1cU6aBNYC8L/eKDoDOHl
         Y/fyn0Gc5IGVDpVK2y4KdWGJko9/xvdwZ1p+9luX5gNt3upfTkghadaY1UATHGgIDo8A
         k/TR/WP+J9NEkFKHe5B41idxYfXaEmwY5CcJl573i3DaJjloUs6TUk4ENynGl0ueyZ6L
         yrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788835898; x=1789440698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKmONGyZLE0mSFol5WqnN+Rq5dtwnD7RFNzUtmGhC/w=;
        b=IXifn3Yl3+nk8Mb5xCawm2DHLAAMGzVwgdXuG35sFCLdWmcdQrHhdBwSsiLYVYdFG0
         tKz6Wxxo62ecRvxKciOXJZx2XZnothh5GwXKaU7ddZCbKswdKho1Br33nlwBTcXSAdsK
         2WR4kao0gQC5qiXK2/7wW5VCdcuwOZr4AFTTeZTjxBMPgdlswFLf9IwuoBuazUsN5a0W
         s14PDWnXm22ukDKM6GIIdZk6VEWJeTOp78JNMZXmfpjq5lPZJi+soNL8ZnDOqYR4BpMi
         Ftl85LbjErtjB1KDxbQpR4dYi5DJCMqlo98/TgCIxJQBrs+AMXiOluxZHrb80MPonOrC
         Ykmw==
X-Forwarded-Encrypted: i=1; AKwUvBzYsweJGuveRFbFLmwwTZyN77HCB9096iObpAMmhVIsKmgShXqL5UgvxV34vZJKUIQbBxLgD5U=@vger.kernel.org
X-Gm-Message-State: AFuF++nigFhpTnS5LF+SN3VvWbOtZ+p33j8f5QjRFrmpIsG/qURP8Ujb
	2vbmtf+5uT3EuB+XNAp7s8uh2GH/tSzzbGDu6tjDT1PPZ88rD8I0XqmUVe0RVzuc4nry8H9w1+B
	nTlMlEOEuwEn1aZiviQcH2GE21hsxtxw=
X-Gm-Gg: AYBFou3zSz92wn1domz51GBDC5akKfyg2iOA565bHCz3AIAV5PE2UocdcjBZznTadlm
	eA+TnR3Q/dQal/lnq/bYhdUoozMhS+Q3ndDcUs6KzlKetoHasRxQCURH28wEhZtpMTmpOvO5diu
	/Ftdao7RiJPVtVQZzFp4gPRSTMEsGMOrD4d4BXRnGeDAvkWzu9Y3dk2M9Y18S0uKqYnKrJG4kgW
	i2homiCHcx9pAMbJ/Fu8KLv7KsPxRTz2t/A/HHzHTeL8ssLutGU5VODFS3MomrSzZPkqA1simyi
	buGvRy+AiWawk8TrovJG2VEkzD8dHe6He5ppXVR1DRUWgpr8QWbEYvQ6+sHgEsGNZB4iIuKM9zJ
	GXxhU20rvD7/rw1Q+tMDfEA5u2v8eijFG7+rCaUuHi//Yh4Ce7jCXftdU
X-Received: by 2002:a17:90b:5246:b0:39a:e983:d4bd with SMTP id
 98e67ed59e1d1-39b262a3cf7mr42316995a91.24.1788835897564; Mon, 07 Sep 2026
 19:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903073252.339250-4-phucduc.bui@gmail.com> <178880965548.219967.14368880612178322930@kernel.org>
In-Reply-To: <178880965548.219967.14368880612178322930@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 09:51:26 +0700
X-Gm-Features: AcwNN1VwiAbwrJcmq7TcgAi0rtpY-ROP8xxDPfs6JX1Nxzg7aEsWZmU4z3Xejgg
Message-ID: <CAABR9nFGduckDNRGBt0NHdSHNPo1pKD1PJbtpw1eUqL200LCdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: xilinx: axienet: Fix IRQ error handling
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com, 
	horms@kernel.org, andre.przywara@arm.com, hancock@sedsystems.ca, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> - [High] Incomplete fix: the axistream-connected branch of
>   axienet_probe() still cannot request a probe retry, and this patch now=
=E2=80=A6
>

irq_of_parse_and_map() has always folded every failure into plain 0,
with no way to tell "not ready yet" from "malformed DT". Before this
patch, that 0 was already turned into a terminal -ENOMEM, not
-EPROBE_DEFER, so there was no retry path to begin with - this patch
doesn't remove one, it's a pre-existing API-level limitation.

> Pre-existing issues:
> - [Medium] DT binding and driver disagree on interrupt index ordering.
>

This is a pre-existing issue, unrelated to this patch. I'll keep this
patch's scope as is.
