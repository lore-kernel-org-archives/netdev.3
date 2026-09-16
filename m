Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986251D534
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569629; cv=pass; b=GWiz9WpbyvA9zk1d93NVsCHfIsi4+x6p1hlJLr9PSL62DMLrPm983h9/JUWwZSJWlmYI/LOnEGf51w6IBV8dusIebY229YLspiRVr6diSjjbzVeqYy6zqImquTxBJQYN8kBlBGaLvYz60ZkRUp46JmA+cJKszJq54NuN59bLXxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569629; c=relaxed/simple;
	bh=vp4KwM89HW6Mu87mOnx3Jjun+CzeYfFbeJpAIlmE2tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X63BBGPtZ/Qqm6ayG4BOr/f6yRM67TbUeEqdiy5WCDMNNK3XaFSWgGO4yDrNVEgZBS5OpBikqHk7LtCT52hY4lsca+rBrKbhtgP8sEuyJegz+ktqpfSqExuL4iTSlGSFrCSoYu8Tnib1fiKFcxi/yvlIstEek4927TPUDAF65UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJBiyv1P; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJBiyv1P"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb1fso9521111cf.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789569625; cv=none;
        d=google.com; s=arc-20260327;
        b=Tn54iHRwT9ZrKHHopc9qJsHvAh51cHVDgsfwbZKofYba0+S7ABs3EKXsZt5MbP923B
         +rxW9Zdd+ZTFC6HAz+MJQQSHvTjVK9vQQI43sdC6DbOt9YlOfeOHQeXD0pFPudYKyhrV
         /YCy6UHAnWaU/zQUeKoTCZNywqKR2yqIuVzOU65LttmtN+ikEYVVmA88AkvW3kU0vaTz
         kHkdzRuQzZ+tkIAaoJFjUktvK11eemc3fpPE62hIJq26GBkUg/XWF7TFQpdaaApFi6VT
         P7DuhoIzLSpMUQfvC30kVPJ/bJnaCVlPNOGTQRjV+RbDHMlP3prxehvPiA8UkR5I5j7f
         eDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/vIKWuIBX4Kniv2CRbgraghVwxNf5MtIz4CNVAHs/k=;
        fh=vzF9dozT/n/H4nM7e6j6FheQXAv4etv2XwsLrmso2wA=;
        b=H+j9aqdVZ0/bAKZJokxwJi37zPwHFJZwYy1S2W33Wb5CWe4C0bF5SZu3tbE5PKlyo0
         FPY4Z+m+TlB2AWLM3f2yU/xSOiv7l0+wlan3C9bscpEu4UYUBSdOgXzMAWqzwYzWBrga
         JV2wKRzXKmh7oDH6pqvHlftbSoWhXaJ8ICZ8D/Vcgiq7H+D7nGC/BxZ8mAbeG23kNXxK
         +M6xOM5NlffnCmzeNIESpqKWGP7jPPr9LbtYzlVu4KYYLKKVI6jQ3uKyjCIAltmR4NEs
         rL9sisWjAtaiymN3qtWqT1Aq/CMvzVvjSgxtDMmBYEmxhQSTMf3KyVtX9WVyZuhC51qK
         EWNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789569625; x=1790174425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b/vIKWuIBX4Kniv2CRbgraghVwxNf5MtIz4CNVAHs/k=;
        b=CJBiyv1PSw5+b5iWgIeoGWrSKkVHjOGSxr2XDWqQ6p2Wjzm+gwVhmNXdllA9fvKaSu
         CqCDHOE2bi0cskuqULzPZ8NiA6f6ohPlsw5lQDrUqkPtbocMw4RUAgYLpIjdDQ3do9Ju
         HyHgkJXxcmC+10Q2yfhZNI3evMkS1G3hwjlm5WDqRPj0AUOgRZ6PleNUfSDqHWco4zVl
         DbVnvfOzHNRkTizgNMYmrGXKh1cDXHeVrtarKH5Ii6CUxC8iGzqnBTUND24SKDMoSq1p
         vxyKA9wGu4gcNTwR4XvK6qwD7bBnJZv6IXK0H66C2bKT8Ifr5V8OdrXOexNA278F8rI7
         dkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569625; x=1790174425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/vIKWuIBX4Kniv2CRbgraghVwxNf5MtIz4CNVAHs/k=;
        b=X+LVY/eU3zuQaUYnggYeQpYJ2qHyjVRcwSk/Ytl4cSc3bVB5j4SCvh4VDGIBNA+yDI
         MNB58Nl5TCQGdznJpCGL39+UV+sZG0rbO9955DZkHSlVeZZTcGYKLw1soxPlF/BqwQpI
         O8QXZrxp2a/DA28BV5fvcj13Z5oEhn4ALdNwPxSRUypF5Gl055N6ZtTtZTUxUzauHRuZ
         7GwCvQxYPz/U++sgbE01vG++Yo+7MbjI+y6lZm/NR/tUEX49vrebBKT+Llb6YOiRnvIF
         d3wMu7IC7dV+7ch8Ta1g7rX4u/iOoyXFxGfyeik/PYF8O2w1EdjhGsicaulDn2Z1iPn8
         dSWw==
X-Forwarded-Encrypted: i=1; AKwUvBy3L4jmCKY/knGNK3e32Sv6rwL6CA9kfj0Z2rzvcFFXpSXoqp3qdGe8aNKGvFZgoW1pmvSNlSg=@vger.kernel.org
X-Gm-Message-State: AFuF++khd9a91B3hAHwjr6HyUzhr5jG4fcf6qGXRHQEAu1V0owtPKKmj
	GPos9/zrcMcjIaISGJARA4AXXIGHU4FmvsOwtDhcKHxx7vvg6KRtCCYYIXLVeCz6J2gnOtnDZv0
	ORnonXY/b5f05+yeqQJnVx21/6egKmCVZsxb5Sp5p
X-Gm-Gg: AYBFou3vhM9cJ3odku5seG66lkRDgwDQJBm7DR7oUbb6qA5IF4V/+ItHWfn0zVQdobZ
	vKp2K+6FsxsjT480ASutTfFTK4VxRrcFzEKdiuWPbmQnwt/kzCA07Q4H/Xetn/T0npO1BZhsG9i
	jPCVpWtDEO42y3OrxXGIoNvEIIDvG3AO0s+zQRUIGz6IObXGgoKSAdViXc1hhBEDHqaj9FrTGjn
	Pumix3EvpcEOnmbdJvEpK27a2nv8QuzDiJrJVMriJjr3GcqlgqEyY1aDo/wvsbJOXwqSp9k6aqt
	BNe/0bprJuVuXuKYms5iiAnfnOMI1SnElvIdMAU52Q5Ec6qrFHbPnrVUhsrDt1Xsl1tjayjDobY
	gia9SUFrAiIQiqvQ+OKD/BBAY9eFZX2+6d2SVUSNsMsVll5nMsRAL+D/P8C7mxTJK0nSt8cfiLc
	Ll3g==
X-Received: by 2002:a05:622a:1646:b0:530:42e4:effc with SMTP id
 d75a77b69052e-5327f1df88emr45422311cf.41.1789569622237; Wed, 16 Sep 2026
 07:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916125316.988044-1-xiaolinkui@126.com> <20260916143520.GA1046072@shredder>
In-Reply-To: <20260916143520.GA1046072@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 07:40:09 -0700
X-Gm-Features: AcwNN1WatgbjaIV9yRByLbiQKUqUshLCda1YzGkv91esZJlFP2-kGMTRlENDWcc
Message-ID: <CANn89iJubkwk2enqcZoNKy2_B0ChsrQDzZB+Gjg-X2X4dKQtag@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4: fib: fix data-race and stale genid check
 around nh->nh_saddr
To: Ido Schimmel <idosch@nvidia.com>
Cc: Linkui Xiao <xiaolinkui@126.com>, dsahern@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:35=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Sep 16, 2026 at 08:53:16PM +0800, Linkui Xiao wrote:
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> >
> > fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> > source address with no lock held, while fib_info_update_nhc_saddr()
> > stores a new value from another CPU as soon as the preferred source
> > address of the egress device changes.
> >
> > Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_gen=
id
> > and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
> > in fib_result_prefsrc() after syzbot reported
> >
> >       BUG: KCSAN: data-race in fib_select_path / fib_select_path
> >
> > but it only covered that reader. fib_select_multipath(), reached from
> > fib_select_path(), is a second lockless reader of nh->nh_saddr and was
> > left bare.
>
> Nit (not worth a v4): This reads as if 195374d89368 missed
> fib_select_multipath(), but back then this function didn't use nh_saddr.
>
> >
> > Moreover, nh_saddr is only meaningful when nh_saddr_genid matches
> > dev_addr_genid, as established by commit 436c3b66ec98 ("ipv4: Invalidat=
e
> > nexthop cache nh_saddr more correctly."). fib_select_multipath()
> > skips that validation, so it can score a nexthop using a stale source
> > address and skew the ECMP selection.
> >
> > Annotate both reads with READ_ONCE() and refresh the cached source
> > address via fib_info_update_nhc_saddr() when the genid does not match,
> > mirroring fib_result_prefsrc().
> >
> > Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches sourc=
e address")
> > Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
