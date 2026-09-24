Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7554749CB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262954; cv=pass; b=XLVR6KPLoAlBFXWY8Ixz0ueugJ85DLP6HgjP7JNphA0WKqyw3npxDR1dV/Mr6uEAaHeDPS/Jdf0oynJzvBtAZDtZ3rOVkzrLIojg7xxM4xPA8D+B8QB+rJF2VanzOXAzKrL98EzMIIuYo31vBELpAslN5AXBeAarLq849skRI4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262954; c=relaxed/simple;
	bh=RECHEgWIei/jxGkLITuUpx9y/MZ6IMst7oKgmvhC2+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+DLJVr9hb7dlLJPqfS5X3ee0JW9s3s3vWJNshprP8Lzf/TeJGwgzfvpkYF35XT1tIBQR0DfunNDVLtfL6iNZ/uX8pJnWyF+prn0CPF7IwiL7oGq0b/+kQpXNPvVD4F3EajMYU5NBBM/Nm5SaRftSrFHwikx8kex0xWd7pmfuUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlvLe37Z; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlvLe37Z"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a9d74e8292so11769a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790262949; cv=none;
        d=google.com; s=arc-20260327;
        b=ZkZlCLEVmIu59UuPYVuMxljfGPx4T7twBUgC2S9sRFJiMjFEM/BbWR7xu+YVYr3jzH
         0vHIj0in54XbETS2XuvTQ1ghoeb7WprEni6v04NnoKNAy2Cm9lcknsNhL42ixxcFDwWG
         zLiTParcdcgunFqxYiIoKRuh6l/+je6P19hrB4uSGG3tFw/DKLTY2JNJtZDRgK73LrwX
         9MVECrssqohwgFH71tgSRLxdK/bszeTIqODsImcWzxLuFjX5l9xsrmccAIXVQdGGn1L6
         bQTwv0hDSmHMnB0nAMQ/Gtk9wKqABcsTQP0spBW/UEnl499xjxd5hfCRyZSH0pBdlW4T
         XUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RECHEgWIei/jxGkLITuUpx9y/MZ6IMst7oKgmvhC2+o=;
        fh=wmK9//F6yrVL0pYZxeonuTZeCuyCkgPHs439uVZTXTo=;
        b=EIZoRoOUe1hFeDyPRWAZDqIvqHZ99504xR/PWMJ0Egop3Pi4wqbBk27bQj5Tg6Nuqe
         JXjtOf8WvHGOgI7/ner0PR2rM7fUenTdl0/CQFFqTPCc4qtkIKHIhi+25gzxHzKdmxzO
         JUlWOmFFcoMV3h2NpOEZejXZgSvd1NOamcp2ZR2r083hGzB1TY65cdLH7qdfqjtORVkr
         96E41T06ihHyMDSSJdZ32gMiSWRa5EuwTNX4d6FNJTCTFN1tPzlE65cf01i1lXXm4v5R
         WEsrv9ko7upIkJdE5coD5nb6zpRubT7JEN9gePUAlG4hUQwZU3WGWI2DQazIwkBmrOX7
         WIYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790262949; x=1790867749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RECHEgWIei/jxGkLITuUpx9y/MZ6IMst7oKgmvhC2+o=;
        b=PlvLe37ZJmj7FZABwp/4xMFVlPs7W5a/XCFT2Q3ViZwnJ7mV6NhWJw25KhbfSEafe1
         NqK/Kxfw1nUuLhrhCXkhov6Ek0cm7nsAcrfc34blyv78IkmgEgWjl2fm+AKviwoZ3S6T
         eiWZ6FXvtYCa/8yELRdeHPn7cdPiw8nptTsZKT5P2LdawvoQZBRvUYA10MP4cJeXIVcl
         lIjOCQKN+9GCvxWeoSnD/MYUguRqfr2IVIpLt0yfp5Ok8s/NHwt7sPgWUxNtt9G/VH+s
         EU8dPy/l7wnWdR5nyRThT5UYOV0/xkNISOQ1qpp+PXBauwT4CjwiU6wYxRlIZfk5zBtr
         2urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262949; x=1790867749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RECHEgWIei/jxGkLITuUpx9y/MZ6IMst7oKgmvhC2+o=;
        b=wCJQQ1+3C1tcuYaw4pb4qCxh8oClYNHye0skv948QZENrKYOPaX8HB4cye2GMudfdl
         +RXQRDg08pzSZp4xK2saCBO9iD/hv+x93pmYsjaGeMs5rQYKcLbq9OI1vlGzrhUtYonS
         Wm5an5LHdJ7OLkweQWMJkZu3vB6ljRcQddKpbeLbZxZz/tBJQJX9KBURQlWrQ1AJ6jxI
         0F+S85/anDWsHKY3XJwZKMyWq6WFMvkjSgu7FJjBfr5kIAWKn/Ydx0wcRTR5LLaGTV3O
         uM27/riZ7Qzy9ps3vndxpsJ2ybLtupdr6enPlmiuT5JEYcK0VYHP8FPl2XWccOeljtnv
         8PVA==
X-Gm-Message-State: AFuF++kgtDTX86yzlv8fd4HzcBPUo42J0lf0A1+aGmLBl4idmorDqG73
	Z2NbDGnUFnltz/7+kebDwZXOsgO0lrEfjLICxZLiyEyyecQ63vlFLRzA47v3QXHWakojw5H6HoU
	CesNInp1fJZOMuydLgKNci1xPMHW5YfTamFdUswPa
X-Gm-Gg: AYBFou2Bx1ETmtvsvSNmdqcBLFt4FUaU7MOZUv/pQJoHjIGP9LL26PVpkyalg3xVOy1
	Z4Ov0q7oIqgdKIiC9u8KTfouwOmg83p/sBToNnHR8AjjVtlcGv7j4TIOeM7IOntKrP3ndTRTg+U
	gwn+eLlNYWIS5xCMIZlOV14Y57dwFdzLWGiezmjgWOH3/vJszkWGEhAQK0Ceu/nzdI6wy/fHAg4
	9AN4djWVC6hzAJSLI80rVvhfX+t7aRf3g70tiHQipmtKfUEV63QBpRKcUhT2FwH+1yptV3daL5c
	1gzBRGwAOuWGkY6gULemSxNswFmPXD/68m7Kl6lCwVh12mHDcdzRjIhFwE+Xls9QfBNBPyjHLhh
	oUEbjXQ==
X-Received: by 2002:a05:6402:12:b0:6a4:abe:b08c with SMTP id
 4fb4d7f45d1cf-6aac7cd8cd0mr57363a12.12.1790262948354; Thu, 24 Sep 2026
 08:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922204348.717198-1-sdf@fomichev.me> <20260922204348.717198-3-sdf@fomichev.me>
In-Reply-To: <20260922204348.717198-3-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Sep 2026 08:15:36 -0700
X-Gm-Features: AclHuK9mQ7wBmLYlao53PoD9EwGQUdhafzCv_xaq_MELOi3IUAiIHmHh_W2Qu6M
Message-ID: <CAHS8izMA5p0EsAv7zDZPabwLWtSGeELjS=r1wHUu+2YPsjQ-+w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: devmem: use memory provider helpers for net_iovs
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:43=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> Use public memory-provider helpers for DMA address storage and page-pool
> association instead of open-coding page_pool state and accounting.
>
> Zero the net_iov array because net_mp_niov_set_page_pool() ORs
> PP_SIGNATURE into pp_magic. Reject DMA addresses that cannot be
> represented in net_iov metadata.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
