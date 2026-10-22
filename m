Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682399;
	b=bmgoci37b9A/m/ermgeSrXnbJVxp8vd4Euh1mY2VbwT4G5aYgT6idzlvox83/lJII7gh
	 xtjBpwqGzr1ytyhYx737NXUAKcXWK+wL0r5yhloKmWbB8p5t31IgxbofZ6bFX7sL6jqNT
	 3NQ/oXlACsd45rUP9Wv9JvtG2EsD1j2peyuoQ0F+6DZPPY2ZIyP5kwjKa7HYu+XnjEfBy
	 Rx8wnUegDNVQjshh7NNo8I4Afh5a2YT/RTABfw/Zkv0nD75f2VFdE2pkrz83Nl26UnxSE
	 QCEYdDNRCrPIrUZtxUfHTD+xE8okL7XdpWW6GWaU36IxSnkTx4Ic38sJW7DVc9YA+Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BnrGb+jh61PMEN1A1ot9ztMiZjRmoi86+DfRlEdShv8=;
	b=YnEGVfyOxXU+tii6piEa6x+5FXthjWkJ442xXe76ObFkHx0mrGJct0Gh1lwyxbjJo/m2
	 G4B/uqgUuKCHge7XEyppeRDNiT1BaPLKuajaW5deDTB4g3UDmrpKNEtN0kaT7rV6aGpTJ
	 ST/tQqIvqvsiVtFtZW6nXcOVfjV9HEw25tNXSK8pLYTcaN4V4BgVrpOHDjeAs2WclvShM
	 20UL/OJLPKs41zQfuCTwwjcA+jtxdaq8uhF6t6GkZm+ThI5Uw0y+wqYm//3kujhb128tN
	 Dv0l8Uc+3YzIIwmKg+KAygda98a4x1FpshqNUSDqqi+YcJDzyALX/4rLjoblsSWX+AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UGo3sWyD;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED78606ACCE
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED78606ACCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UGo3sWyD
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso670939137.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682398; x=1793287198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BnrGb+jh61PMEN1A1ot9ztMiZjRmoi86+DfRlEdShv8=;
        b=UGo3sWyDPsmJGz5uiFj1jATefs6I8baOo4CdN5OOqaS2lnhSCS4q9Nh48633sePedo
         8yZUX8MHrBCHZbIiwZLHOeDGZhOMUwuiN2cOSdZCcHecU4YcoMgEFojk9xBmS22ocEDc
         VouDirwRRkx9nKyKuEdyCoiOb6Ra7mVtyfIXEgdECFSfdWO0Y50mf/4ex6uyfecOfCaH
         Vj5y3jVHqY+CLi3tEvClmRodsbiu1bebCp0/KNDDKBrtkwT6r40disEYaJr1yURTUQ3L
         tWOIlQCeAthkeLE/sN05iTgAX7omusfraSySvsyY+dyxVOQ8tpgrsLFP8q25WJQS3VW9
         +Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682398; x=1793287198;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BnrGb+jh61PMEN1A1ot9ztMiZjRmoi86+DfRlEdShv8=;
        b=Gila6abBkhVkBpatXTcsR7tZirWiQY0UQ2q4mg3nX2dINaNwycXgm1w4ULCl9Xgiie
         0NLjPCRar85yClMNbYbPk/OtyyP+VTJLMAoJ6waQZC7rxwA54nDbt6/ct96wJovBJcLI
         0G2wgHQgxGTPBe7QzlRDy7ON25CSfFDbFU1ANQtH/d5rRQ+GT2obrvQgqzt00gY1Q29n
         ouW0OagMt85z720nkmMnWQ5Wb7OKx4bazdv828rCjAQbHJThkdX4P8UyRcgZLFkb9AAY
         pwlZHB5eb11NErJax6K/+dZ7Lowywo7OJNFqKLsm8ZB0QriuwIFRCYtWQ1x18KG5w+rJ
         HrEw==
X-Forwarded-Encrypted: i=1; AKwUvBwooX+X7XDiL2qoyfX0aoXheE3XxpsWF7tAC+P6DoADvTtiUE6djWo3T88fEtZGqM9JyorK0nE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMU+iZ7qIAw+EFeHhV+k03mBYjBjWmxIi3vhuEIh+BG7PlQjOe
	A7fBwo9XjFvn5a++RSaVRo/tvdQuHRTJQMXTpnKhCywVyHSeoBoxDKnZ
X-Gm-Gg: AYBFou1ylF3SGvcFfrd9WAm9TcZyb97eIWik8/zEwqCezyAhN6LzcWltRDNxUmPOt+/
	DXjGXQW83K+yddhGGcQ93lhx1JjRCJzB+38bM2D26WCSh5vzo0PEFKH9cWdLjy5LvqUBoWHPcmf
	7q30FIvj8MwC+UZ1SrrxACI37J4bCVg9l37/KsRWwip0Hx/pRfJmBEDlfdm7V3ZaE6vgsoXU0gM
	nmw1a7ONeZ/pnSWjNP6L0o6jMSjrbcKy9oqo8aJNrmBDiFcpVGig4IYg1MN+2RkqGKOz9/PWlu3
	brBEYukNMJJ25wuw63S1SYNe5XOhmk+eKoOsRHmhISyG/7ZmleuhxavBo4MkXjUxZ/fGuItUfz6
	TrU/5B6LY8HdGAiJGyHQ/lC5i3thoWEQQXuUXu31dPJi4jJvx1AkL3PkwedlpjtQOjwxYJT7Nql
	5X+DEDJbbHeUwOx4N9x0hyax7Sa1XfM09Mmi09VrNiBoq3QSQ3zlszTJd3/IIiYBslMZrMGXZFF
	qC9Zd+Fc6P1ZWy2o90Bnuo9AQtFkZpmpvT3kvO+EJqBJ+ad8wWghSYgxB0mvODbv0P9VPrtbFZu
	VqNXbFCVk1uZSgKriJuyOKqV0rtqbkUExqOvmHGmsdb4dHE2Rebg1WAIJ+eavJE0QIaFvwB2XdE
	CQJWq1BqzITKM/XOEVV0=
X-Received: by 2002:a05:6102:160e:b0:7a7:195a:1b2a with SMTP id ada2fe7eead31-7cc9276a1f7mr1817213137.36.1792682397951;
        Thu, 22 Oct 2026 08:19:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9237bbf7sm6580982137.6.2026.10.22.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:19:57 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:19:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Todd Freed <toddfreed@meta.com>, 
 netdev@vger.kernel.org, 
 toddfreed@meta.com
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Cosmin Ratiu <cratiu@nvidia.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.31749cef483da@gmail.com>
In-Reply-To: <20261021210200.788191-1-toddfreed@meta.com>
References: <20261021210200.788191-1-toddfreed@meta.com>
Subject: Re: [PATCH net 0/2] psp: drop packets with extension headers in
 transport mode
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Todd Freed wrote:
> While working on adding support for socket-less psp associations, I
> noticed that this case was not being handled correctly. It will be more
> relevant with that series, because it adds udp support, for which the
> psp nexthdr will be taken from the inner packet.

Just curious: what is the plan for replay protection for UDP?

As PSP depends on the inner L4 for replay protection today.

FWIW agreed on the ext_hdr conclusion in this thread.

