Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680261;
	b=BeUU5X+Ywv73DpC3pY1FkyaJxep6ezMaaDoT65htQF5TaQuBBF5KX2zrwAjsBJGbmfkN
	 nOPz5kogFJd/vYSfEBgyD3DFeqGlXGxlamMnQgV4tSyBj6QXHPCTEujY+T5laDPI8d3vH
	 851Q2NU6pMdlV+i9jaVbGLXh7UQqh5L5LWn/xh02YgTv0Br0Rs6O3fKN8tB7r6r5bVOER
	 Pwl04oOiUNH1DUOePfy1KFNK+pLIJ3ckNz6g9zHG8vc6rTAdpnw4j4SJ3l9aBUvE5ZTFS
	 2j+W+0SpPvQ8LtB7v3mdlL7WOGEGbGZgM0QpjJuCtVC60s1YFzXcEBHAXirwNlmkHVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=90WOJxWEiaSb44hA6E+8FSqt8JtTiu4IKceMn/DMgMo=;
	b=RdlRJMJcIKrW17/APYXP16FErx2RfKK246y577j0cDcMPAkvPpF0c1WRXHBKVpBRDjk8
	 W1GZa2QtVYYSusw6mL/f/v3/DMu5XkfFM7xOvvNH7pqUoF7gd5YS5c/cnb+diRFGp+j0n
	 m8D1NrhEZNLoQqZafcWvf5okBH+b4kP0AbhAvhj3y7UAVTNVvTIiBWI22i49h7CmAlVgR
	 acYiDHBufmWfNMTeUlf7c/OAFsgDt3CJdAycjo7SHDgKdDcEPdxOpJi9PB0bwriAeAVKW
	 lIYBenAtbtVsqXOpcA7xPXFN1NYe6kCe5eWGeXjZQwgwJ6VZ7hFEazq6FH3n8eVjE4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMG2TSXS;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47C606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB47C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMG2TSXS
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so1693362a91.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 20:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680260; x=1794285060; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=90WOJxWEiaSb44hA6E+8FSqt8JtTiu4IKceMn/DMgMo=;
        b=FMG2TSXSpexOAMI1R0qiDDsNi0cW2BEassL1KlQmjhbCHX8oo7zRZ32X+cKMEEnja7
         4h+LBPtoxT7W+2lqj5VO+PBagtvEL68B7J/ur1soU/glVuSIly4oBI0j0dX7PzlpGzfF
         onoyMOcLUUR6h5HeWTGfvb4b+HJ3UqdmLXBhOz7n4mwY5e5VLq+QxQ38+gk0c9PMCGyj
         G57GZP7vKHbp5lZ0N3oT036O5azXtKf25gWzlys4l3TpIycHsEjAUnLwG+YnCf9rqxoD
         COawC5HlsKPqDNEVOrNE4MwZfF9HNB2LiM6xNJnQPgYlLUyFddjMn54WdRFhsIAUZl+v
         Yo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680260; x=1794285060;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90WOJxWEiaSb44hA6E+8FSqt8JtTiu4IKceMn/DMgMo=;
        b=KALsZx76zB55xRgAsCrUkiWV5UUtt2BwOfPdBGDxPl1Aw+sGy8akpnlFioyqQ/5QfX
         vIvo4xFj8SyGysHIjPcN99vhfW17hF2v+PEF9BwjC/KtMo/7YqnzQTO9/ACH+Wdk3yVL
         zU+VHhuH/wMEQBm9tXSMhHru2WUSus96ax8iZPh+V6zIs8Au7pX/ZZ2cMmqdQn5AuC0r
         k243AwW/+zUjyPVxV2i2SyZtzOM7W4mh7LHmVJpEI9LASuU711B8XNWZoAVDC5XsEXLU
         h/TOjYM2ikKqXdws2Dpi0IgavyLrmue5NPlmP5tbsxTQ8vHb/YW5LMUrfu3aK8ep+ry9
         +V/g==
X-Forwarded-Encrypted: i=1; AKwUvBwGE2iHZabEERLe8TXxWPmVy4YAArIXEjLjeHNj2yseaFTJ/DL5Le7JdVhL1/BUEKpO2FJ/XqQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rgTYf07mh1fGCyIpFAHvwdiuj9fEIB8TCzlk6Eg6dqVGKtMcP
	vJ4I5ZEtaYwFeErm/yWrY82wC5bmf/K8YcsVJV1CWatjqsmWoylcGjIe
X-Gm-Gg: AYBFou15LYRS8m5UCdhvhp9QafBBpFPzNHlD1JCW2WIN8pAi5YfKodzXSfp/y80hLgg
	UDu/I/1H4BtBl8ALO6nyovO8/39bigW5+WorT/poEyvibvbu9Yz/95VnbJyF+MP9XIncm26VLvt
	eP796LMjB2CF69pXBnLSBcuxtCYrLhgh/Z3QO6UziS2xiFxbQTdneJJUV9QWIQgIqoxNzldB90C
	cA7Jd+Fq6DKQAiNdlc7iCpfnRT8SLhulWKCEYRIB+F2R6gvQt0CykDkCM+D+dYtf1imGhFnPhjM
	WkLihD3X0DJR6uCDeBC/7ZYh7P53ruaJxZmQuHd7vhVfMWXVrqdcnEhEmxXlK7SaUbVLLneTWTL
	BGDGnfDIEKAuhFAI9gU2hUgz37w7sSs0y8rwGVSw80kT5p8qm4XuN+vr3V5pISgLYrw8NlR9nEQ
	caKv/Rqq5HxhHwlOe2I/aRmqfiQttxKUsxNV3pe9BR9iyDNav/83Iaob/CDa3fslIHDNZR3bfXU
	LIo7kUNArIEJru6FFdJ8ritcg0Q9/d3awcqyAsAOJ0IuY3DdWRFyMkKuTQHnoH4K1zyR9s6LfTh
	P+TmxERAXDjBQwQS8WT1WZCtoyCbWk/tQzOWRre08Ryyg6v8VTL5nijme5w+5wS3jxgZdGnTtPA
	qye4SQzH844EjmMqU7YXAR6RnobWi3XuTcsc=
X-Received: by 2002:a17:90b:3812:b0:3ab:c80:9362 with SMTP id 98e67ed59e1d1-3ae89776da4mr9524287a91.35.1793680260307;
        Mon, 02 Nov 2026 20:31:00 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928c4sm2067891a91.15.2026.11.02.20.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 20:30:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 04:30:59 +0000
Message-Id: <DMLAL3JBM43I.2LIYO7PJ9XTN@gmail.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <bpf@vger.kernel.org>,
 <stephen@networkplumber.org>, <dsahern@kernel.org>, "Willem de Bruijn"
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 <netdev@vger.kernel.org>
In-Reply-To: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 07:35 PM Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> - Move all info to maintainer-netdev
> - Add a link in bpf_devel_QA to this location

Acked-by: Alexei Starovoitov <ast@kernel.org>
