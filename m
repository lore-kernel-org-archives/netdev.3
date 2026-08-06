Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29C3BBFB4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041939; cv=pass; b=EcVyA89xCwTmL12S/4xwWK5sz4VWfus4GgOQG/VnqdrpKdEBTKs/EhE/L25dRNnr5OGbVjl8WE/6ufmhLGeC12AAdAypmzZADFtyYsXwXiL3QVdcmChWrjVjDanKNQotuiRIyEZruWL7Aq7+832wPYI7oGVpxNH+OxyJhGeNWJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041939; c=relaxed/simple;
	bh=iy2BqG7HpARO6nN67aO4h2mkYvWJ7FKhVDHBSoqKrbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brDQf3r/G+xJcj4nuP5sli+HOWe/eIBWkUxclkJzNFaj3vkzFi5AbYxrrhX4OQlEUwKFBWvW4mFDhWDOeXsn5quoLwckbMLN1U2roANRsZ+w9DTsehQMXtF7q3QuyvbsnLFv1UBrkDR1q+ppiqysvHnVA8EbvfcRO9ImumF8JAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxyTpZSD; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxyTpZSD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e347638adso2891293a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041932; cv=none;
        d=google.com; s=arc-20260327;
        b=BqqF/i3IT5zckh+2T1jtwRQPFvMD8vGutZpV+FOP7VE7tVT0Gk+m2yg+R9u5alAfmz
         txfpFwhYA01XabcAFiYlXF7w88I16sRs3OHhF5jn/rFB3ufK7gCw2ud4lcvZqW7/GkN4
         IKtko/bmBAkhQkceUb3ipgs13MMFkg19l/uqn7XX4xv1z6BjRK4oZ5bgiqYdbOS+e40Z
         JcPONuwMrkgoU2MX31qbO/TGzzau3iJSx9bgXqYFD1odC1/H4tzNGWUHeNZb/Rv/2nDd
         pRv963luDBEQXycu93AqWuHNI3QwM0tqaY+btxxUEZyNap+i0+89cA0McjzLfjGczp0D
         R/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iy2BqG7HpARO6nN67aO4h2mkYvWJ7FKhVDHBSoqKrbo=;
        fh=xIb4XuX9JxAGtdM4tZOngI6qL2sYyLNMzGF27qsQHkM=;
        b=OFdobaI/m62ON5/bO+1tkbji7xXoS9iknEAZPZd7apgRjvwOuHKWFnMpDMUhZJ+AKN
         zz6FNIpjB7oI8dzuyYXTU/BdUe3WBfPalRWxPDliKZm0nDEtlD830Z+V85uOleJfsxr0
         yU2f2ki/P3tqf0sulKwQE4FpZFTwTmWMnLT5ymmF+Um/zLEtAbowCOUl2F6S9wgtLhfq
         Ayj5PHegjGhY6I3rYiSXXSS7vidRZu+UAUDlAT8TZcyz1PPwpxBik8iqfljHv+OYyaRT
         xwTpqdLuwzKuM+bdGwTn7qDJOsvfvryOWn6MM+YR8arNdEavOMtJ5DR7Y5KaTLCFO7qC
         +pkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786041932; x=1786646732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iy2BqG7HpARO6nN67aO4h2mkYvWJ7FKhVDHBSoqKrbo=;
        b=hxyTpZSDUXBcsL2xI9hkwEv3BEt1QqeQsCvJgRRWbdl7WqPX+4GIRZiQ7/vtgg/xPu
         5n9B02Z0qwB10A+2I2bZdmRn+XFPCQjlqk5cTGyvGKLrwSkc8/kZT7Cvg7pQyhAe4Q/R
         oXHYsdsEznj0w21sfw02vUL8QC/fWgX2/JpEMvMD/EwBVtHH7/zxE7QfekGpYkP7a9+7
         gWX94eko9OC3FovdVN716cHUC/mRpxk/7uUiVv9v9usmJktJOfLSL0V29ezY9iie0snn
         aQ0DWCvMViE0fta08iGDKRYrq6Uqw0fSnVjGSWPkO1r8Jpm1XnaXznlz6TNLO6G5/E8C
         bxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041932; x=1786646732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iy2BqG7HpARO6nN67aO4h2mkYvWJ7FKhVDHBSoqKrbo=;
        b=giV4N2UDGKNZypiJdRqfLMlU8XL4WIztQNDc+Xx+8ZPMt+n5rh+urEXW6Yduz5376O
         OR6sJZHrfN4T2VKpXHctZFTCuZaQumSmz1mzfxHKSHBprZkUnSEymmFJqwty/OOKZfvs
         /NloV7STiDVKsSL10MxegP54njRS6BhMObOSznEFvTCmb3RidiEjK8gojEcDCDyPADWB
         f5Jx/zKdP8ezq1S/ZkSwFZcC97lmuZIleNfri65d2eJnVsGb3z8+hObC/e38yVIS+hJs
         6iHccb8mCMeyMgLUYp7BFGYKR1SvPDEhnHSoNePcw8XHT1qI+m3/F7vSZpf0UrPduBWC
         JGLA==
X-Forwarded-Encrypted: i=1; AHgh+RpHcsnnLnQ1RjI4EM1/IIaTcdZusUrBaXK0b1Kwq/eePtG+JJvSoZPIu6a1aSKNjHiM7Jk/NFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoP8AT92pXFSooc7N7RfbA+X8kzBACS/GjhDeK3pIL+oyShwh
	BwyVwB5NFWCMqlIXqe+w+jkrEaMYubj+u6LaZ6AEVonzSZD671zC+Blx8ea2V0j2rdUbeN0RiaI
	ynZWTAU1Qr90TxnWd+DxNjKGDeKpVAKsZPn1i3u4H
X-Gm-Gg: AR+sD11rMGziapfeqaUubUki/7ePWNAw4JxgZo4WB8lHwigTdZaRwyXxSqigkNO7cB1
	xZAVZRLftvcmjYBoE5sMxRHPW0lfVY5XO9ryrqO3gzayX/fzmbrrbR3yibzH8TiIyfw47qYZ46u
	OJfoS56cVgXzffFPB0eI8uhCWZJvvmOlQVEHazQnRarupweLkaE0YcD1FlJusjuW+lbk6vgILkW
	6PEFNb98rPMvd+ReuipUxEuILUyH8ChGtGgXXlY/42TnZHOWStpAl04JQaRBpaN0syzUp9Z4I/U
	GJo8M6WQIm1hZAyXBi9QmdI5yqRCpOn/bi3ZD1idSndOc757hhwLp736kffhd9+v9e1veqrJEyj
	jJJhRiPgVmNez2US4WQyKwbw8epH/RyUVpBvcXwbzBLaGfV66TFxRYWlW+XRX0+SWOzmxmWdl2L
	0/ahVxtDt8W4Q=
X-Received: by 2002:a17:90a:da83:b0:38d:e0c4:c955 with SMTP id
 98e67ed59e1d1-3903c5d84b2mr16857708a91.15.1786041931401; Thu, 06 Aug 2026
 11:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804002155.2233594-1-kuniyu@google.com> <20260806172900.2962014-1-kuba@kernel.org>
 <CAAVpQUACUFcdUV_TURigYp=-wDamvN2PBQ+c+njYxAyDvmq8cg@mail.gmail.com> <20260806113649.4d7f12b9@kernel.org>
In-Reply-To: <20260806113649.4d7f12b9@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Aug 2026 11:45:19 -0700
X-Gm-Features: AUfX_mzoQIHBNX9wtAWm6Ul_vbEIry-YGVyf1DBUm2GdRmyiFKehZbb7v_RjZ7k
Message-ID: <CAAVpQUBr7zgpPo9BsiDCfHo0sME5+SwYSLeCB7ESk=s8W5rcKA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	kylebot@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 6 Aug 2026 10:58:56 -0700 Kuniyuki Iwashima wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email says "I meant to send this yesterday, damn. This is completely
> > > separate right?"
>
> =F0=9F=91=86=EF=B8=8F

Ah missed this, yes, it's a separate one.
