Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F23CFF44
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550966; cv=pass; b=YovihDvsA7e4l0zTheJdFkTcA/ZNpwrOuSNmkIMcEUDQ4I3kxo8hNW52YqZxCXqjsQTB/1KZLuYAykA43BCwXMo/tYYUusSIs7srXcmQY3Z3ZZ5q/z/g1/Tq3AQB8zbRJmx9qIY5CMUTPm2Ej5bvxtD7eG1h4wPMlbCk9/DZG4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550966; c=relaxed/simple;
	bh=44no+aTwDcnd4uzLysjOT/27sdbnt+n4OvN8AGUiCEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmZb5IGVqY5fHLNgU9NBc10usVP/e74Hx5/PYFcwiHxUDqCnb5MYv428iufDYUICuL4CG1T2RKENf/6s9DjoiQmVlDc9yJFze4Z5XHYv7uqNOq9M0qjsCE5u/3qozX97b7ZlR9gXdIwZxm3Z1wUICYkNsuyih9GoYKqbPC06SEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooeE9GU6; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooeE9GU6"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530de452c33so5877151cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789550958; cv=none;
        d=google.com; s=arc-20260327;
        b=pdeuXf+aq4mnyAD+lsUe8o/dgtqcbtBPRLSuBBq2cgcJUaKPaBrBhl4wcBUcIQYkz6
         +d6OnDhZZ0tkRdGevDHhnf6hNpIOtwy4prSKG64IpcAcDLRfL5f4SikSzFnzxBxWrwQN
         HZvJ4QU+X4KXj/6dnOnPyIdsHa7ihKQMlZiBFgTjWHbF5b6OrYVVDsu0AyT73+acgPzc
         G31ZdZ0c6Y//QAJuWamZslVhMXDMOLBiI1x98boSmCtLLGbB+xalMJSnpDfqIWm8R9EA
         yTcuQHBXcdgWMndJFwlo1M+IiC2ESpG1rDwwgqXBMk72p50geZwxVemRkpxwIi7+tAoH
         kyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=44no+aTwDcnd4uzLysjOT/27sdbnt+n4OvN8AGUiCEg=;
        fh=oynUkq4wwpyHZv2sTfobLOW6Fq7vGci6bpnxQZTsLV0=;
        b=BKgqzEg5SOSIi5qyC5e/v9qabFsMYF1fMOUcKQpaW1bk1Dl+kzDfZKa0v6BjqTcmkb
         LB59qjOPkuTvr0JTvrFWgnkvS7vW/yCZdt74UicnafEotOMh8jZtraZ4AuTwksV4ETWD
         8utubqQTagCo4aF4xm992Fj+6DexQCv059JjHuUZtSAjr4eEWSaKtOniwmDNm0OuJ0k+
         YjXsmOo7Z3aosPU749orTiiBgiTiRFvNAgknPkm2wQY5Y+Zvcm1IDefrazsjUuUFtCDL
         btcFClYbVsmkUvxwmKwbI8Kq2WtriG3VpN6du/B4F3KmcffrlnXHfgtrg3WahVPmaYNa
         Fj+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789550958; x=1790155758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=44no+aTwDcnd4uzLysjOT/27sdbnt+n4OvN8AGUiCEg=;
        b=ooeE9GU6C3I/fNb4xQYC/8uaS5odbtBTtoXI9r5SPvyKoGLwva7UUHyMPY7e/4L6BD
         y/B1jW+UiTS51GyIoQAJFhGyucz5t5D758S+3Kc93gQPWBcLH1SXn34GIBANLFaqK+Ez
         0trHGMT6xFsJAcea/y0+ttwi8R7Ryz90bF/p7g8CzsjNMiYSuK62IFeInOFtEvHTu780
         VFiJSYBZr+v0MQPBqdraBAWk/Nkpisa/MjEu9EhbkoH8GgHraPA4hVCsB5blhQdOKbf6
         Nfbg6XUtvZKyFBol9mQ1Dijy2xPpiW1W5w8ADBZDAwKr2gXGpKZ8U0tRiSgjljP0Cfoa
         cCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550958; x=1790155758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44no+aTwDcnd4uzLysjOT/27sdbnt+n4OvN8AGUiCEg=;
        b=1iDifVNIetjUqU7uw2WL27j2JMGrfAMQ8FVZe6RLqVIs+hWC2FwGpsBjxgmhrK72bN
         p0Iz294B0H9+s3MOL0h4iblBnJbobdHkW+ZXek4E/sU0xRNXwDhbQgaMbBL4bunqNWC9
         NVOh9+TpPXLAa+JRVHamuP1D6YNgbGThvlt3qcT/paQ3Rwz40qJ1V1JMWStXDXQRvCT/
         aAECC6TlyhUqCzZWTma8mKPLSGa4ro+tYooZDV6KD5y44LvB9a/slxN0aa6NOIwnxiyj
         jHa3UyjtOpwAQzvxG8wd3vicTk9Z9Io8Hqc3SaByriVqUEIfASdzgNGRsYHHA01PNGmu
         /ZoA==
X-Gm-Message-State: AFuF++kkvAAbW8VZVwy1aILxLIAMbw+aOBAsojbzEaRV/GyejPbvHoGY
	QOSxXrw9RuLIMTndJhTE3+YQpIGRMuFf7QSMFz8zfTmaDW0XGbKKwO7O9Ce8q5zDyoCGimInQ6z
	GuG1EPAw90KK3HPqR7ufVrSGIldeQtkVnE4uqZnDe
X-Gm-Gg: AYBFou1kSpnTXYC/MATV/+fBPjvmX51mh4YABulj1V/ZA4wJwfY1LnMtD0zFAGznKbn
	ZL4LcLrJinBigGUDBg4E3dRaNk1WLh8aCSWkNOcbk2UEj06IzziGCom85409vxbuqNBW5sDyZGk
	C5gWxK14uYQemaXu1WNYXnZpOImy9SKD4f5RbM+OjTlyII4xR2noudSXA5erBk5xqbEr7wUtKdN
	upDUjjaUGzMrgU8y9wN7e2TPknwJ/iuqfWhpFQF4DLSlS5foMRpFcnzL3r/zGKZoJiMYRg40lqN
	SkItlC2QDSuqONnVtxLFxN5LZ0uY0Vbe/lZSBcceALEYc98A2+bvIuyX9VdJ3y0g1OWYFm2wRrN
	K5oCXNhlP8Rz2Rhw8Jgxkx8cTo1PlYVf8Ja5E7a3+28nm2MBdDzUSLtvGImNeiFVv/Tg=
X-Received: by 2002:a05:622a:14c6:b0:531:175a:c008 with SMTP id
 d75a77b69052e-5327eeea255mr29425931cf.50.1789550957317; Wed, 16 Sep 2026
 02:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916091420.138170-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260916091420.138170-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 02:29:05 -0700
X-Gm-Features: AcwNN1X1CWoh8b9feW9tVwJMRZULvvtYZyX4fVsbh7cVt5oUeAvTT5amUc0vIVY
Message-ID: <CANn89iJFRhGBt+XB19NYKUZQbVMfC20y5W_oPHHZjOTuemKKLw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: gro_cells: add drop reasons to gro_cells_receive()
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dong Chenchen <dongchenchen2@huawei.com>, 
	David Ahern <dsahern@kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 2:14=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> gro_cells_receive() reports SKB_DROP_REASON_NOT_SPECIFIED when the device
> is down or the GRO cell queue length exceeds max_backlog.
>
> Pass SKB_DROP_REASON_DEV_READY and SKB_DROP_REASON_CPU_BACKLOG to
> kfree_skb_reason() for these two cases, respectively.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Thanks!
