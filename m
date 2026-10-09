Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481501AF0BB
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510913; cv=pass; b=dwhozAxuCNMKNqa5+S8BkNirSQCwRu76oe+n5Ho+/OgXq88qWVVT/MKGNTxxhr1mv4B6ZNEJtnTrJpHdCAYnTUo/AbTuUOhjLa5FtpQB28m+ATJvp9uqAOFnR4zwj3URXUPn/2lsurIsUsY8fHpZcdcUNT8TYV9nGV4k+vE8ojo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510913; c=relaxed/simple;
	bh=7FfE+Gjv/oitWMZfuNkc5CF1K6v6lHM3CtNTQ6IgqBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmhOMVbm4bxHWUnp8rTDfNRKvxGCf4MpnRKSJtW8qczyuGcDR7VsMbLfjvj52lVlqYasDVmcaoWRopeAijACjlVbRgk4THkdxOF2R038ABBno5AurycZw4TOQsWIdNya9E1W92CuP6NVcKSiPVJyADJnfaSBczGZYLh6WYzq5Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek6dfgqt; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek6dfgqt"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e64d52949so341019085a.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 18:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791510911; cv=none;
        d=google.com; s=arc-20260327;
        b=VTj63KkEh63gDiMn3C1mh+cxIGln0FC1+2yXCZWvG93vgFToPMF9L9JCtc1r10FmO6
         sRQg21yJfGluJ1nG4NHzdaR9KJY2SZUoWiT3jLhfWy8IOURZg65WwbX8k7WZ4/o99sGv
         DKTdYO5euNmT2W8+NO1P4a+7j+gRAPU5V+xzWVkgHtDxfFNqb/SytYHM+ryeL89yrBZp
         SzUAmmePj2z0QQ94iGpTHYHPLdeMPO8ip73Tg6x2PjtI+SU2uzDqKQt1uS5GLgKhuejO
         T6HTGIzCADLoXloAJUBMsR7Wc33X06if1GQnss4xsFrTAUeyeez64o3HZDw4u722NrmA
         REqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        fh=EHCTL/BsQZGLtn4NV/6av07P3xEftemFh1scGsVG7U0=;
        b=ZwvzVEJzaeSyaGGU22ZrHO/cgqmtQieWPLaVcB2vZYseBoEDsrV3j24/VJUwkdxD8b
         GfCqYKpOyhwW8Yl3MUgutkQ8T6lINrJ3ro44tK5oAffKHS2vWuNuyaZWu6ajrJSnt/4i
         GeaDPgcoeD+jY6QA1b5rcsmUxwYo42dO2XPyQJmJJCQwV4KLVc1GAzCDIhC9R0PFuNIz
         WXdpskV31ZcGRhNejIwRwXPyqRZOc13fm1LuucutLJvI6vV3STfvlADUahTiUsmgISLm
         nayrYQcxpX72DSAISt9HI0EC4E+5PaYm2OEg5PwbIk5FJJfLcWv+OCpMrAXO8PZ2UUR6
         2FEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510911; x=1792115711; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        b=Ek6dfgqtJGMFnOaaZI2ajABVdnx7qHW+nRCj/Ny8PxOnr/xBdhlk1ccFKfpCSKZk3i
         rU9sWRuxANy3nJJVRb1KX/2Z/+RIlTptDvA1dzkHQZ7G8A2Yj6O6RkAzusiCOsPamDjk
         3o90/N8gnoKFC6GsvulJwo7wQiQJWCkylqIZ1XIN4humBur0tCBY9hHlV1cX5i0qSIb7
         4MSITv5Bh4HczFSj/z4P4n4AjWhofNoXw+8lBceQbMC0tTkz1t8LgG+HfzZCFHb3KMSn
         2YtUYuYtP72hr2Bajyg9h2fclsmYR3fJxy9lYfF/L0PgHPtqkss4bD9oUG3+hLwIjMh4
         VlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510911; x=1792115711;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        b=HCd/kAVXBnUQBiqCD3hXmH+K1ZU29qlXCuc1EEjRJl5d26Q9eyBO86eiz1GdU4lWo0
         0z+ChH8zrel3JtWmzbyllfIIm86xHNr3jMP7C1K3iSZlLrzb9B1kFYzPo7NqDumvXj8I
         x4jE6d7Wl5v8OiHmhaN5kqDnlhE4XXWIrM9BgjmOhzMAEG99NTf8GwFSIohJCD+DJMAl
         6UZLwXrE7PuUfesz8WftLlcecYRie4VkYOeJnt0oAOsejh3abpj4c3Q8mFaY1PmwMXpg
         IHoXVrN4Xuc2w2YnXaOViPoRTDQxJKbD8IYmPS8iAIVhoaUYV6zjAGAcb3EWQhTPvHiB
         iqjA==
X-Forwarded-Encrypted: i=1; AKwUvBwvsDVCzDcaZiwnvHPEbRcM62X2hcvs5WGobZLB+w+Co07rFPnLHlIFtz6PgSs4Q/JiWIfMObg=@vger.kernel.org
X-Gm-Message-State: AFuF++lFCJrtyoFpKeD5LsPeIwd2E6omEdQdQax/3R6gAvDpTPKYhzgi
	eWvYQtlJ2gD6IfzSPgBBwDtoJKX7R+WGSiGpf+s/NTgm/dURIBiLZ1VNbFWnn52abEua5TNUbgM
	gaH7e4NLjSIRudH5nB5EqhVcWYmDiEdw=
X-Gm-Gg: AYBFou2CaWgIUUdQjrfWxx7UAmzvPdxFFYZvDhSyvb7TNNcXX5GopytnCcsNrfdgYUD
	WhrOxxutv51J0PZ3p/RdJrAs1MXtLnvm+seuWyqkhifSfRmVc0TKcn8dkl6YwiasCR/GReenqJS
	7orWvxB8Dknn3WPa/ihnaD0yCBWp2akPLmBj1y08PSjWTjMBaYAtLhOS3jADURGRk6iLTgMgoEK
	/CG6vPPcDYxEELUAiefsrI0b1FpnKfW95+TN+0tqFbYqbHN6WOwqO2v1rHiUzNUeTVPMhzWanF+
	QbX/LvllayY35DnKBtx83cnTq4Q0txznAoksuh5pceA+7xvXjjFKliQ=
X-Received: by 2002:a05:620a:4146:b0:93b:d79e:18ff with SMTP id
 af79cd13be357-93ebd4b3751mr66750985a.66.1791510910201; Thu, 08 Oct 2026
 18:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006082102.27085-1-physicalmtea@gmail.com> <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
In-Reply-To: <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 9 Oct 2026 09:54:33 +0800
X-Gm-Features: AclHuK_8ZpspQbr1VUz--jCkNxAVH4PyEVkIwHKuXxRYnqVazc-zqTuVcZPApWY
Message-ID: <CAJwVaMJCgJYJP3Mr5V69cxFe9mNGmG+SNAeP6Bv9+cYc0vnr=Q@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: do not count PI bytes in the data length
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On 10/6/26 3:21 AM, Jia Jia wrote:
> > vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
> > protection sgl and subtracts them from exp_data_len.  The length passed
> > to TCM is still exp_data_len + prot_bytes.
> >
> > That sum matched an older target path which subtracted prot_length
> > again.  sbc_check_prot() now replaces data_length from the CDB only
>
> What patch changed this? Did all the drivers except vhost-scsi get fixed?
>

I had that wrong.  9f977ef7b671 says target would subtract prot_length
and points at 14ef9200.  That commit is not in the tree, and the target
code never subtracts prot_length.  The in-tree behavior is
e2a4f55c6498: if protect is non-zero, sbc_check_prot() sets
data_length from the CDB.  The vhost add has been there since
9f977ef7b671, in the same pull.  Nothing later changed it.

> > when the protect field is non-zero, and only for READ and WRITE.
> > target_cmd_size_check() leaves a write's data_length unchanged when the
> > CDB size is smaller.
> >
> > MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
> > the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter
>
> Can you have prot_bytes > 0 with those commands?

I did not describe this clearly.  MODE SELECT is not where prot_bytes
comes from.
With VIRTIO_SCSI_F_T10_PI negotiated, pi_bytesout can be set in
virtio_scsi_cmd_req_pi, and vhost does not check that the CDB is a
READ or WRITE. .
A MODE SELECT sent with that field set hits this.  That is what I ran.
