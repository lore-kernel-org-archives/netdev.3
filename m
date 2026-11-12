Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494090;
	b=g1PDUxPMoaCVUWzMyXJTeEdijC1IvnFP3FzuhXUwzoUBBPJt8q/WmKs3AwFBWobbF4hw
	 EJtIBt/5hFDgvIb3GQhk47EJgPkEmLAZA7/1QDwxlojQMxmDVj9WDCuFJxYq917nUitXP
	 Q9063WCxp+A4kmIHG53GmoKM5lI7x39b5cI8Ex4u0OyCWKxCRVfxWl/W2GJm115/G8/VI
	 8LqjgRna3ygUYyATCf6vzO0g3MWhSYoS/M4USn6HajK/LLwXyulTSbCJD9tfyBwYqRTEn
	 9hhdRa3csI5xB+Aqb0ZtqqacQoO6enhxfEZcLpcReUKMZ9VQ9tkQhKlaGQjFW8/1NOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=6MtxvwIy73ZQd4T3DqnIV/Zb9NugLeP4diZveyex/dM=;
	b=ZHQxjziqwtQ+QgsifS4TkVIOot6Vh1mOtfMJ7VrfsFleuzsM7FDxon44HvqE4eAn/QJ+
	 sPb1Nhx4jaVgSDjvUmcyg4Y/Fqll9mknD+TlmM5vWNsc6vQ/NhlhGuHJ/wPtvDo58uD3p
	 agJ8uNskQtNjW0zIPsuFkmh0xYKl9b6Pc4jQt+tnEugH9XUn0NMHGkppxbI5sUgMsW3Le
	 diLXmj5cKNSjlmrvT76ja+TNeuB7+R4sWZYcxWzv0eV6E+bDDz8TCPUzRjM2FfG/8s++8
	 iWjP9Xd7XjBDEA116Aa32fC9wIf0TjXdyFJFVuhRlTka3PkwHZUaR1Olgf3Bp0xoVTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UcTEnzY3;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59762606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59762606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UcTEnzY3
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1736315a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794494089; x=1795098889; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6MtxvwIy73ZQd4T3DqnIV/Zb9NugLeP4diZveyex/dM=;
        b=UcTEnzY3JVyJHX7wVb1daJ5vKsNuRABAKkdJFDdsdjQFcTP8SSCLCAvdQulbSXIn8A
         iggjFyQB9RGqZr+mEInXST2uZ4OENbWR7IACpJEKhNHaUD6qvzz7DON9j+qbME1WfbQ0
         1ibwTnAjlcQi3Xa4D7BdWjVvUd4jRiwkKBjL4pSMhmq44ctKUTy102EqX9UivB/YKOXY
         Ss0uJJZzDWD2Tj9CPwaFIh3FVgvmhl0sFkbqmuWF077Ty9RvWVlBx7BCuFWDBckwIz+Y
         cKxxdIuYsu0l+AJYT/HOt2nsZx7Lgz6UvDL83onG4P9YMFDy+Uxdpf5VCk6quEjyilXG
         9RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494089; x=1795098889;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MtxvwIy73ZQd4T3DqnIV/Zb9NugLeP4diZveyex/dM=;
        b=m6+kwJCpce1SOoupH52KvEjU5zoBQiBFbluDRB9RhiJF3SAlECaEATdn7ys9TbBczK
         Q7+KqSU+GQfAn+CJZREoqll1ZEd+vbnFobu5Y7c8hEI3BND5c39xa9iXL5ZmvmzBpQ56
         BuuIIw8oVBt/KMvCIXavyvJzKY51EWkwNnA3AJWJWcqd7YUyWtEoTeELAOvUo28kcdG2
         CGhbonJ2S4Brtt8R9yAFZvjpC1YjKpo+/FxQ1o2N/M6hRQY1AK6mAHYnlIb83skDR4bT
         jfRGqHj+QwU3AmsUJPrl+tGlphsS2DT7hoDFeAwP3QT6VKTeCYiaURzwKNzmYDUgTf7o
         BxpQ==
X-Forwarded-Encrypted: i=1; AL+hErER7cGsTkrOcCwVgg9WNOiLHdfE5Kcn5P9281ExQ8oPCGNz2IU2JUA4IfsEt4YSTpHee2VszE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NnYLp7+LsxIQCl2z5Gq6J6E9eklQkwm3FuTmfCwTK5l0xuF4f
	4u6rDcGqClOKQvqxvG8M/t3veLrcmxc+L6OMLDgaUcVN6oQti1VmB7dpeNResP2c6Oc=
X-Gm-Gg: AYBFou2bivy4C+P73sQqW/fI56YB+EQXCF1nmXH21ikIoqfpH6Kq08og05jXVfyzoxW
	J4Er+UsqKbEEWBRMsSsSO/ZFO51OfpSTsoq3Gnm9b7C6KbeSjSGTi1wDrbYGuJAurHb7HYJ2zts
	k+RehVvDbhJj1Jmau5MSsC4eN58PtH2ZVb79Qw7xAGBVCuTBYniIt7n8UqVhADLz+B11oq5UoAo
	hM4aU1ZZOH3Bf4F/6u7whs8fNYSwIibeLI4D69EgouRvCyX1cYZitmPdGrz9hs3fTasmKQPvD5s
	srDbeYF+mNu7QbVtOdxenFtyKDm3SnDfUaIM09IK8H1gfzIXWZBftMtKiuUX6ZoS3meMeS+TWfG
	/A6/HhSH+ZaerlSsGdud8749PFq67/qnA4sd+GfXHwIVAs2oAvwgvLD9TdN48fOkwp3W8+xCdTR
	Q4buTssr37xKUAtteWS9A/R6xyp1pHjqV+LwZLDzTACMBh3QnXD1nPivfp0Km9Yywf/1pPDZTRP
	RGeeSx8LutOepP+1Is6DDZrCpuKcGMUh2WscyZ71DRPBoDI6H8IOArNGx5SGQ==
X-Received: by 2002:a17:90b:2e41:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3b182f9e1ebmr5131067a91.52.1794494089467;
        Thu, 12 Nov 2026 06:34:49 -0800 (PST)
Received: from [192.168.122.1] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b2cdsm4868205a91.16.2026.11.12.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:34:49 -0800 (PST)
Date: Thu, 12 Nov 2026 06:34:49 -0800 (PST)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nfnetlink_queue: use verdict sender portid
 for expectation events
In-Reply-To: <179449333655.2168702.2394012834202740473@kernel.org>
References: <179449287223.132952.1536491080157978119.c244-nfqueue@gmail.com>
 <179449333655.2168702.2394012834202740473@kernel.org>
Message-ID: <179449408688.148684.3959110286947423131.c244-discovery@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

TkZRVUVVReydmCDqtIDroKggdmVyZGljdCDsiJjsoJUg7IKs7ZWt7J2EIOqygO2GoO2VnCDrkqQs
IOyduOygke2VnCBleHBlY3RhdGlvbiDsspjrpqwg6rK966Gc66W8IOyImOuPmeycvOuhnCDsgrTt
jrTrs7Tri6TqsIAgcG9ydGlk7J2YIOy2nOyymOqwgCDsnpjrqrvrkJwg6rKD7J2EIOuwnOqyrO2W
iOyKteuLiOuLpC4g7J207ZuEIEFSTTY0IFFFTVUvS1ZN7JeQ7IScIGBORlFBX0NUYMK3YE5GUUFf
RVhQYMK3YE5MTV9GX0VDSE9g66W8IOyCrOyaqe2VtCDsm5Drs7gg7Luk64SQ7J2YIO2MqOuLieyd
hCDsnqztmITtlZjqs6AsIOyImOyglSDsu6TrhJDsl5DshJwg7KCV7IOBIOuPmeyekeydhCDtmZXs
nbjtlojsirXri4jri6QuDQo=
