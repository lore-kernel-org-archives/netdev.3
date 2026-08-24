Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CED332635
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583665; cv=pass; b=iKrYnlL0ea9sWGj9A3bLBOiQrkSpq9cDO8H3nAHp2+6X0Xt9nqZi92KRx6ePBMwLTk6UwcRkCgLaj350San2C0IVUBAg8iC+BPBCFRu7WgTv3V5H/Dxt21PSzU0p9BlpDDf+6HALtteP41ntBQUfy2rhiGhAM2K8fNO2Z4yHNJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583665; c=relaxed/simple;
	bh=WpVnq+ntAGgScWTdKSDNdOhQC5/FcTx0nkg+ImijbQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED6CLDnVdT8/Dnx41KBFFjh5bWzvxx8Nvcv/XvUUwLV8SzP2B2vpo+JsnKcJV7jK1HE5UFk/keqBPAZ13w/Di7t2K6+o+qg1IQP0SuhBMl5friCMT+yu0FNyzsb1YAyz9AN6dSaDQTeBoShAl9IZTlzY5enNZzKB0ukG/cps2N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2BwZhHA; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2BwZhHA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1676648c1eso25462866b.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787583661; cv=none;
        d=google.com; s=arc-20260327;
        b=gbf7LntTZwMZiRT87v39COk9puCT9X32wKUmnQ7VwtvLn17v2sXcQkbLfF/2Cf7Xub
         bBPBOnWrhy2t27MyZyUI20YfbbTr6aMZQ26JU0oF84/n2+r5RFm2UVAv4A8xTD2QU7/9
         2kwP+rmjFkeB7JqCBO/NG7K6ccfq8dxm0BspOmNOMPrtMki3T/GKJ7badlqlo0wHKgu1
         wMlsv+aF4v8YzxBPW6cT0nudmBT8F7ZYD+1LCoTLdyw6xdCDs3srExKa/2rJSb2SjSGO
         LG5DqsWPltlZGbj3hjrNn8tLbZAzuXyiFFKmK4U6jW0JDBQnrrbz0wHrpys5zSRffp+F
         wmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgcpP4OgafJk7JGskLpMHar0BIaI/o+NTn8pY+z0mks=;
        fh=tyKZzspdlKjxMOFA5CEiICvADHEvRH+UpCRtjkIHpEU=;
        b=HW1cI2C1WcdMYZM8O+wPBvPD8/8zYykMA/zSH3PK3khG0a5OFVESS2+J+ATFXYuL+r
         fc7Oq+OGcml9EeEAu09LJngFYZg6gS9l75vz+xgR7f7cuv9uIVvs10xP7kWrtRwyvpsT
         uPz42zYEhnubefsGGJiG/pLS+7ofxy0EW2gtupfFYLJ01kFYAKLi60K71ftmNEH57aT9
         cUg31Dl9fn6dN58LoHPIqX+e3mhwiNpZNXk+GRnf63VkKUbr3Kk5DWevwRiEykNCajrw
         cOKy/RFVbRmXJ3r7PQqFkM+VoIfstn9MgaYENIoGmdTF2Zc6Cz1SmUz1OyPYS7OjnfaV
         r36g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583661; x=1788188461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgcpP4OgafJk7JGskLpMHar0BIaI/o+NTn8pY+z0mks=;
        b=B2BwZhHA+1r22r+jrDjO9RBpVzUuuZ4pcE78MIYAI2tOJn69EnSchFLISdBVULxTBM
         WKo/k2vpKEBvPowAFMh3f5gWgHpAsFd7e7fhlnoEQXN8KgKn0+ICVYjaTSCRcXMBaF7R
         OBce6P73SH1n98otBTv3lPeOiWpv9E0WTADNUkJqV04cI65lTfp5UWc9duVBOK3Awmxa
         oODC7KL2W7iiwteRgVBEDikMs5O7CvcNsm8x/79ONZruXMy7AzFXyjXzeWmf/j7K0rp6
         tx0fZpiRvBNBG5FcdBrThO8N+Z1m8CzZqVN3fRyHGQFnP+vqxH8vmdl7HMkdEY/XFB0O
         35vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583661; x=1788188461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgcpP4OgafJk7JGskLpMHar0BIaI/o+NTn8pY+z0mks=;
        b=otOJPUKZK5E9ft2Y/z+QefFBMSv3xGFEpXCdeOHrcL5Cpg+yJOtGwtzrt35rdsy5Tp
         QomEQrOCQqMU7Gzmo35uIW0MmOjZDbxO2jFFN5zSRcHVYJKvft6IsiobDqmnUG5IIq7f
         4vIOVVy72NWTIQt/yPD7N/KmdPA1MJ8/umujjNVJujp9BuvpuXBiBfzW06MlOPqCe/YH
         ej/kRVQyGuwTN69VO9MFcNkvPSBmrRpYvODFGoaR8dyWeoZQouY3PiTKvXNuEF9w5SMg
         pmezbt07cHX0bIFJ10Oz4IAvFfwxbtoKE6fXmozqEYSSEcLb5Q1bQmFh9Zs1nPtotfir
         5VYA==
X-Forwarded-Encrypted: i=1; AHgh+RpGC86mloHCLWOuqoRGRIy6qgPxdomFCkNuQtnhcZhywefKpNNcQaBbHaITFnEKJ+4yh55fDVI=@vger.kernel.org
X-Gm-Message-State: AFuF++nLkHHerE8ygctNlddDiDumWe7aeGCsWoBAspJNQAdm1vBIxilp
	VdbfFNWMs0G5qWxRtXMSFTn0FrPn2szQM3umh0nir5vqucNX6JXl/kwQwI49KWi5POw6/K731z8
	QsaR1zvMTWy5mOLBTluEwCwcqIOSTktU=
X-Gm-Gg: AR+sD10A8wnULDP0zLkgzz/bhzHmISHl3ESluB1GmnSBpPTP9c4slYm1Y/Aywazjpz9
	QGTqrPNx5N8P4YQzLPbVU+ERHw6ieM8oWBbpLhGajSwBdLv22vsDvRdF6jtbZQk9Q7EvAIeSJBa
	i52W5u+D7Uv3NYYs6N3AcWFSDw9Pkc6rPC9gNk9ZpYV4ukN0vqwVLcbwI4DDWC10zvJJFZyjAUD
	EkXLo8D5E6y0ZjHAlPh2lfM4BLqJvzAAsC9TssMZqG6eoJxYv54qc3WQq8j5RSHOKcwQadFL9Xv
	SQy+qpfNozI99j8FjAh9UW+ocgwMA31rs+WdYYx+771GsRH7wHUN8fZQBwk9pewaEMk9YzxWj/E
	=
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c2469f96e84mr1529651466b.0.1787583661010; Mon, 24 Aug 2026
 08:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824103709.98373-1-lucasp.linux@gmail.com> <01d2ce1d-7864-4f77-b6a5-995e01638935@lunn.ch>
In-Reply-To: <01d2ce1d-7864-4f77-b6a5-995e01638935@lunn.ch>
From: Lucas <lucasp.linux@gmail.com>
Date: Mon, 24 Aug 2026 17:00:49 +0200
X-Gm-Features: AcwNN1WlzAUkr-0ijIjQicUxVMZtblRaXJdHqZkKdW-oY9GSeAKzl0-PTYeu2ZA
Message-ID: <CAKYXYMQ+ndt6jpxD4hm8WKiBMJVXpoAgm=PtQTVgGsO4oQZKFw@mail.gmail.com>
Subject: Re: [PATCH] net: 8139too: use unaligned helpers when setting MAC address
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After looking into this further, I don't think this warrants a fix for
the net tree. dev->dev_addr is backed by a MAX_ADDR_LEN buffer, so the
second 32-bit read does not actually go out of bounds, and I don't
have a concrete case where the alignment causes a problem.

I'll drop the patch.
Thanks for the review.

Regards,
Lucas


On Mon, Aug 24, 2026 at 4:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 24, 2026 at 12:37:09PM +0200, Lucas Poupeau wrote:
> > From: Lucas <lucasp.linux@gmail.com>
> >
> > rtl8139_set_mac_address() accesses dev->dev_addr by casting it to u32
> > pointers. Besides potentially performing unaligned accesses, the second
> > read starts at offset 4 and reads 32 bits even though only two bytes
> > remain in the Ethernet address.
> >
> > Use get_unaligned_le32() and get_unaligned_le16() to read the address
> > with the appropriate width and endianness. This also fixes the Sparse
> > type warnings caused by passing __le32 values to iowrite32().
> >
> > Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
>
> If you are targeting the net tree, you need a Fixes: tag.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> Does this bother people?
>
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>
>     Andrew
>
> ---
> pw-bot: cr
