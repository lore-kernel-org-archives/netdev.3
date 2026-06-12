Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B335972
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246937; cv=pass; b=KcVdyls/lKa/pPhJcFZN4opgIRv00yAGRxHiXzpzSFUBMTjhJV7O5fikz4yH0td2RcX9RsoyPpavXFxFxgvlfsa9zKD5jalYR4eVlCqms0Fc3zeP5AL57rcKpiRaHmCV21AZFCL26PLGbkMEoLpTj9rCzNHsvIzbPVJ7Z2NgzS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246937; c=relaxed/simple;
	bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqBAAqojLcU2eKabBaUIgwyjfvMWfcj7MXHjC50TEolc/4D/b/AISvncAaWeRVo8Ob2yul8N/qcrtjBb+fMOVJAbCdIwIrtZsvsXq9zfC7MhERG0OMJIzvLkNoFUVB8yFF09Cv8G8h13qY+Ye4+NuhXjAWbhJfWnhGzA0V0hIrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBeoX2Pv; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBeoX2Pv"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1383e116edfso685909c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246935; cv=none;
        d=google.com; s=arc-20240605;
        b=FqJqoHwYoOrfiYskN/qMjryh1qEvWkZpgIBUpo881Jqd1aRfS+fA1fj+C+ZVa+xFbW
         Ky9e/LXHC4i+HHcNTTd0iGPxnTbIKKBQSeoFsQMTg+YqQsHMUEGWOHhoIA0/19nKjAM2
         VZdaf3kiQtBbtDVw47lq8ZquJho8gxZ2WHkM8z0sY+FyUY5RMtCQcQUVlhMcXW+vUojV
         jke+R2E7oxoafkCB8xO1ib5Ir9Fu1NCEcNedpaVjT7/BIkTCfseqLPHWbkUX8SL1wU7O
         /ogb69TP3Eg/+H+VjgLf0gJjmlVRb49dXnQBs6v5Q9szuKbqisGIVnFbwCFDe/0cR6PA
         PyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
        fh=eBiEgPvH6sP+kOLgW4+juti4N/qIS8T6bKbETikkQ2g=;
        b=Wiu6FP5pz5BjSIdJiSJr3ClB72sCxjWCPFSveNlb1i3DWcMhJzGFAADvRrnrQyBJ/G
         bAM+ZJNFUmGAttQG1CAI+5sj63RS6ylpFxG3wbiFN2yJXBG9UWBkHaqqvPeIxrJ5sjdR
         qH83T/2npP4S4m8LtboE8qRFQFTBhbN7dzLrAhyl+GLA9SuhNEE2K27KnXfOxmRqKmbi
         pssGmBWbKUxGjvFhm0pKGTJq34F67OKBIt3w1/3luM4cXuuVzgp7ZTzsmvROdrPT/nZp
         a3OkjcbM5fpQVadVvtjMsH1KfuGxleokm2hmIhFisS4MZrJwRBgG5LWIWmQ2tBXo/3Ph
         FVZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781246935; x=1781851735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
        b=iBeoX2PvooKYa9X4oy7kLjC91K9wuK9UHMke5dvRCVzoEslEwFrkLS0LgcnivfPTN1
         M1/vH5o4ikPac+ncqZkOzYMuUr4UnKJak2MVydGAEVG9vzDtBRQ2KEkVe307PPBywZYA
         +L+lIkw4AAHY7bwTf6+nsP0b6UK5JtNjAJVI1e4MSg3erqQJ7+ztjGlQic1RBAvX71sH
         rUMbhJ9BoL1VERlOfx4pWZa5TG6bxMmFe8RCc+tsfcLPLjN+gegwVmEbY2BS/i7MyTjz
         IEfeWRN8SUjJ60H2O+F/3LcX0TvImpEmflO6LUxm9j5i7Ckpvzg1G0a9AS5/ZtuzMlAh
         tbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246935; x=1781851735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
        b=fj1Gn4u05rB3QCv/lw/48FvbkLx69sjJKJx/Mv4NCmee16RhwQij1wjAn/Hz6uT8/y
         qpvKWL6rfXSPcpgB/To8Y3ICpmkZzTs7Ztz4fsx1HWlGBchjo8aFwAwzCuiAnknJDgef
         AqdfvYQ5SGYSVrY3llv2pTe8fyHzKlC+4bYwjiHjK412xvNNREvVv2oSPGuTXOP/w8I5
         WF7Nd7wJ2hfIkqgbXXNM3xMWBWZMfFPz0KrT6uadLqqFepN1tKpYjONKrcLlETfNRiXK
         EH9m5nzvL+a5yJfZ5FxfGG6u3BoXbHP4A7OzVvruFlv0zGl1j1GRlFUMlvXfvdBmqNZp
         qbGA==
X-Forwarded-Encrypted: i=1; AFNElJ9GJ1ulv4Nlu8zFLy+/EuRnLRufiPa5x5cyjb7pcnM9mfKIe9O/W2Tr/xuJ9wR3p4nu/4P095g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwc0y/3yhlOhDlHcAOn5G71T79YnCtlpfRu6675EikQl+meI0
	26ySRgXyHZBhrdPafnmFCG0cY3L+1qE8GTFQyBNcRe1qOKPxws1eO3XoFjDIVAjqJf71ACEQOuj
	53+PPrwf/+v3Ja9gxl5gplP+AffFtfnCGfW/FS6gb
X-Gm-Gg: Acq92OFVe9J19Evyr5q/W+9Vo4ZBSGaVDGV3g3AMR0muBmmr7mGbylVX+nF6eaNQ+Me
	1rBrpEouLwQuv/tjYzjM/LcneSXKmExkNzf7R5mjePRJHjpQESk1MZq7ZHYG21jhGbTgBTGBMJS
	eXBVyOAzPjtHapPcQdaz0hvPtJU9LH6Tz87f048pU44VvmUoi4fmoKbLsQVaMmnsCaFnYk5tOMa
	Ar+HT6unXSjbhUX66ikqRJBPFc/pc6yJOu5wL2twjw94V/tiFBIsBQi+zfKtoZ2pRuwGZYbH698
	hVK7vkvX8cTuCOahcvGV0lMMogDKgF6m+t3bk/itwiWwyGNz3O1xDKw3yti9MUwARMFY7L6PmX5
	/VjMZ5HRTNJI6J/USXxnTXPkX4vgEDHNK3byF/5Zfj4mKhJzrirA4
X-Received: by 2002:a05:7022:6886:b0:138:4023:8b6 with SMTP id
 a92af1059eb24-1384bafeb84mr807429c88.10.1781246934483; Thu, 11 Jun 2026
 23:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-4-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-4-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:48:42 -0700
X-Gm-Features: AVVi8CfTT_OjI7diC_WbJE9Auao36PreXQJZM4n8teeX0XG7ZHKPtQ01XJckUHI
Message-ID: <CAAVpQUApoBagChVPPFZFL5+aJQbd7BUrUpfmfOMHnCQPsWL-5w@mail.gmail.com>
Subject: Re: [PATCH net v5 3/7] net: ip_vti: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> vti_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate vti_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")

Wrong tag again..

Fixes: 895de9a3488a ("vti4: Enable namespace changing")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
