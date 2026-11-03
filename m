Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722383;
	b=R5jMUpUFrymKGSWVDtslaj4sK4rNpElR4RxF19mEjkzddMQtGVPWqhSlSUK9+r7rBljm
	 nTqAkpUE9JsMM+uXtzeET6CX7zeAZ01CcHACTm72F64IJFC3oHgaRXJ3yxetUeYwNu498
	 PHWERCz8z1l0FM9zmN42BWierbL2Rxp53jmTKfY57rdFkliD+LXhBym9fTIp/rIrCqhtT
	 LqQ+A7//jVTkim+Jpoa5d5LzeDiqZ7S/rQpnAswx+ZPbJoby656RfhDeuKmYWAw8zKYp0
	 m1MQ7Iyaf6rfsjkn35M9QykCPuVvm6awbd6GXh4gzZty5Exe39EfMpZVTu/S0VAcqCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4A60JE6fNOa97bnDneZpx8lsHJBwZFk3Rbg33nvgKAI=;
	b=y8MusvpteFQfcgRGqI0yEw+DSfaPO3t/GNaUtF+sk8/LYXKnafbnXA2qqOfn4tM4n00R
	 c34r2zenlhtFNuZqdJPITz093fE5sniNjc921a6Llc+u+4eSSR8Jf4YXHTRNJeFAqWyg+
	 cI9vkld1GSkL84JPKWNSHlOy6l00NpoTa9yBftZbvqOPm+8N6o60Rsv4SOp75k8ov4+v9
	 6wJ6jQe15fkN/nyHuCLu+NWnWxtEo5/0j5dJ+3KCULseqkIr6WyzDws3b1g0hhlnBB8IJ
	 NutyQs2VsoR+4Ermrqktwi0XrSMfVJ3X9YpN3FRxLIIb+7zo/sS8qXSYY2cyWNBDuAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LdNwM9++;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32F6082BF3
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F32F6082BF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LdNwM9++
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so9012023c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722382; x=1794327182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4A60JE6fNOa97bnDneZpx8lsHJBwZFk3Rbg33nvgKAI=;
        b=LdNwM9++nZpH9bPkX/2oAdnFguh5iTi3E5a7BiV8CmYQluqvCLCht5gk7bkLsndu8z
         PZh8o5IVC3T92JoG2kQjC1MN1EMt2nFNycV8a2VTj336wF+cDitTXB/oYBB9eM2CyGOo
         mNEhyocQ3ldYpxx3C/Rz56XMppogmi2l746+j8iZXSBJai8AlFrn8cOOIEQnEud7rFjK
         NjXKL4tvfp6Ct44r2OPRAVEZAACXPr4O2DGPLli7Tu7wf4d83cqvvoeOUa59KsI27qAz
         0dmSQ3Vw3wktU4jQY1Kn2p1bDWDX48OzO+W6NPfERXPKkT4d3wW+jVyrPAEZgszSzv6R
         EsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722382; x=1794327182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4A60JE6fNOa97bnDneZpx8lsHJBwZFk3Rbg33nvgKAI=;
        b=p5Wufjr4rbP0IxSdhwxa/peK54LfA1xJG1j9vnVn38V6zcCp03e2i2JE3rq9jXdFoh
         yuR78VQUQ8BtR+EgN723DeSaVBOZSJ06m6Amqq3DIrqEAAfwLnQjUYdB9zllkiMzeIEL
         fWKSiwdBZYR6AXTbzssrCol95pRJFnF1oB6/ZlrQYDH7zMD0B0r9i/4bKWMyXvZsPcZG
         2UBV6f1OGSTX3rAHYWK1Oo/ED5IkRCW13/ILFrz7TfiJybeNeMYqVY+qclIsCdWsgtK5
         7+TjumlftbEZ84Rn5Gcx0xXy8uSo/IdrXSCVb0PNWU1i+s9JLaXY2BQHta3PZw17bcHo
         j32g==
X-Gm-Message-State: APuU4Z9IrbtPkGXs8MtIUvoBAvc5rq8oL8vviU2TmyGS2PCsWW2QAffD
	p0lq8Nwpj0cVIJuKmCx5AU2/Nqh36nlJYghh19pOvXanLc+VUzqqbrE6m5JPug==
X-Gm-Gg: AYBFou2DmXzSSOvAlmzBa7ymjyNDp0M21rHuilkuCRhlL4iRD6z5WCSHqSRXT/ReXcv
	RxkpLhjXLcyqja69uC7lq5vHKZyUjNwA+FhEO7j8/buODZy/2pWhx2iBpVeGu7UMWNEs1vX5Z2P
	KsVe1BBEktva5XuigvE8DKdJBRrkE0LIMR2cxb2XPVDc9FjXlNPNIloDpKtBVjq4gW2tC7Pyp5i
	Ytr4FGu/tE2z5OJAHi6UC9uyqExJrquKFs4sQjD6pcEtELrTLg95vgOXpq8haSeHrQq3b9yUfCI
	8gCbHFt3Tk9CbXFg1QhHbzntIJ1AZ8yMvaH2JDBK7pl8pJ+NyyslKKZaJaSC3kbk5IClIRGKoGu
	Qw7rPKRxvRMxcLovy/kKGzAHo4mrK2IKs9cqtyqTM9CsIcn9DMuT0xC4wmJq2fSVmv7Q+/F5tlf
	awJfNemb1HW/iihAEv0EPEIqbWcCzS1BSOUmBtPHhvUXZ5qPDq37gnCy7OZiWfJQ9npn5Env/6z
	xKBKK/ghScUpaCiLm6v/7hefRYXDCl/Qqk9nF/3p2mCfO4DYOCmDkz6vyow3l9rzbCMEy2h4p0a
	ynlhxlTvTElan9V4eJvDGFEXL0ofF5bdNH+VHzm286ghghrM7EM3j2ikQSyevBt6yl/ZZW75qz/
	SJQVJ9rLiEAut5e0tu9z6Z8tEzej4TPy86pcSLejqibtJTFlspHDVs41VWeZYQGBTE8VoBTVJdw
	==
X-Received: by 2002:a05:701b:4348:b0:196:d6e1:108b with SMTP id a92af1059eb24-1aed79b3f6amr15967359c88.10.1793722381826;
        Tue, 03 Nov 2026 08:13:01 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm50112589c88.17.2026.11.03.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:13:01 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <martineau@kernel.org>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: Re: [PATCH net v4 1/2] genetlink: Reject joining multicast groups no family owns
Date: Tue,  3 Nov 2026 16:12:54 +0000
Message-Id: <20261103161254.56922-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <179372164269.488856.17448970060747076034@kernel.org>
References: <179372164269.488856.17448970060747076034@kernel.org>
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

Yes, this is a behaviour change, and I missed it in the commit message.
A bind() mask with an unowned ID now fails with -ENOENT and joins
nothing. I don't know of a program that does this.

Ido, Nicolas, is this OK to keep, or should bind() skip unowned IDs?
I can send a new version if needed.

The other issue, the window before the membership is added, is closed
by patch 2.

Anil
