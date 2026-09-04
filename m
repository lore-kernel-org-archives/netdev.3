Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E39472536
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528305; cv=none; b=Lzrhave7FjHeJyH3/1yeX1teyjz0IfWavxZMX8RGkfWEMc756AA/vArRTIeRws7O9vS1koD9QdXHxxb6SXKZgQwLv6NaJEt1Px5sMkzZsyb7SZ5xtutodyupz3qHmkqvYzsvV7od4NecFNtQW9hewMA8e4V0aEyojXUa0pgmgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528305; c=relaxed/simple;
	bh=7IrgWckgLXmOp+bSbt2l3lsAkLznjIprg/+l63INEHk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SfV86MwC+xebKXXLWFBIOZeVKof1SRwtqV+2Z9f9ZfLkgLgOgr12ii+MGcMB6JFXL/+Y9F1QKvtMazCA2X7ykiHQbXLQ0901D6qMjaLuy20WeDDHuwH8ofz59bA+RFOi/l7To+sUpaVA4yADfCU7mon7qFtuPJkPTgqohdbilc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io5VVGDp; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io5VVGDp"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8200b55dc47so12010727b3.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788528301; x=1789133101; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EUxRc34t0qU8FOfG0VqqQu2j6hNUb8g29gyCmIO8xCk=;
        b=Io5VVGDp+CZ4sCDGBJWKIvbBPJiL7wXPujE8eqUiy2X6aLrwI6V0GFNbQXCRooi4W6
         Qv5uZ/hg1BMjSoax92jJEjOcRy92hppD5AEQHcoe/O5Dq7KBu2k9c2pZ8B3Bpld8afcE
         wuM87A8bwdwP1lgwmI1ZktnAli1WGSTI5YNC7TlPLXUc2ymBT0EMQ9jwa9V29vtMZBq5
         wJa7XJTZO8ERQw1jeQYt5PEVEsdK2bRNFCQFlFJSEYDaA4lHUPIEP7y58oqzk1qd1APh
         UWHvjbNVibFz9VdcOa8UaxbWYmof45ePAT9TcR2qwvsIZOnD7LXS48aPU7YLQImIFvXy
         4eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528301; x=1789133101;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUxRc34t0qU8FOfG0VqqQu2j6hNUb8g29gyCmIO8xCk=;
        b=PWvS6whT8GwIgrn8xkJjuBgouGoO1kWQGuR7qhSx750A3KijFvp7GStisKoPSp9nCB
         7Z0PJvvAKqJJFeJQb1qwy1gB4z4ZESOt1vT8eXOHaWP7ZL/qSRlVnVpiFbgfXlOZVG4K
         HI35OD1m47aeDhEYe/JLZa6cSbCaD7RoqMqnyPFOwXRFOxHRBsUt7Tga0ZLFcCXO8wT6
         EHm5qKuoAc0v4VCu9YH0c2aD4Hn13pWD9+hJkc1tNHJJe69fLIasZZl7XfDSWGAgLOfI
         h5n8eQCiCvMj73Llikay+Qd8CMnAVbHWgeI2ZZthrg/Mb7vHx/kZkNF95M7XZPx3mEOA
         yP1g==
X-Forwarded-Encrypted: i=1; AKwUvBxe+w2NLb+pxB/Ea3oXMSbeGfMVRITlAAlgLTei95broqfnsPeTEqQnPTAuoyMWojYGeCr3dJE=@vger.kernel.org
X-Gm-Message-State: AFuF++lg1kbID9Yg7uPharzifGn4L2YECRBcBLD+HU0mIg9nX6sDF/Si
	Sj5zDvV8DuXNBpWNAdtN1f3bOXXupDi9exMH5qCuUFTvRDjoEYGFA8lP
X-Gm-Gg: AYBFou1kEGz/+fWFuHrpOcjQGA8cBqgP7lzgeZ3CYyXZOL1U6PbdOVq0sta30pJeC6Q
	lOQOhrT8mWE/1uuM7+C/OsUmdDMvhD6et7n0VVYL/EioorXYTTt8hg2/bime+V2xIV+rGAyl35H
	t8dBlnZDjjWCPXEHeHcaDzcYP/qkQPZLUFr1cz5CGx2Y3TG9NseFrNGT64Wt6CG8GlUoRIcSl/8
	VYVsMy65mkm+LVfWIONYWOHxSaz10W7AfeoSEL60lwYXhvddae498ZZaaWt5Wc6l/0XvuHAPiTb
	5Zdo5w0JpmRMzH9HkzkXx+pxN7DKRuAwKRLBPZIYRxbEalY//LaZl9nRpUGiCdiRanibaWwkrbu
	LqM0ovx0wobbKlbEV7D0vfFnVeH7wQgFg0+rA//NwEz/VJvYkDWk56K1EMxbjOEuxCM99b9xhDp
	eN8fG1uf/IzdbhFx2JmsWEKsBJDYUIYe9z9sQKTjNkqe6QFEDs0mnQdu0KfdFJf4sylQ==
X-Received: by 2002:a05:690c:dd3:b0:873:5c6b:a2ff with SMTP id 00721157ae682-8735c6ba63bmr2923997b3.45.1788528301340;
        Fri, 04 Sep 2026 06:25:01 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406bbb79sm20079006d6.47.2026.09.04.06.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 09:24:58 -0400
Message-Id: <DL6KD9FKLYQ8.1HD909WP9YA21@gmail.com>
Cc: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>, "Alexei Lazar"
 <alazar@nvidia.com>, "Alexei Starovoitov" <ast@kernel.org>, "Allison
 Henderson" <allison.henderson@oracle.com>, "Antonio Quartulli"
 <antonio@openvpn.net>, "Anubhav Singh" <anubhavsinggh@google.com>, "Bobby
 Eshleman" <bobbyeshleman@meta.com>, "Boris Pismenny" <borisp@nvidia.com>,
 <bpf@vger.kernel.org>, "Carolina Jubran" <cjubran@nvidia.com>, "Chris Mi"
 <cmi@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Daniel Zahka" <daniel.zahka@gmail.com>, "David
 Wei" <dw@davidwei.uk>, "Doruk Tan Ozturk" <doruk@0sec.ai>, "Dragos Tatulea"
 <dtatulea@nvidia.com>, "Gal Pressman" <gal@nvidia.com>, "Jacob Keller"
 <Jacob.e.keller@intel.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Jianbo Liu" <jianbol@nvidia.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Kees Cook" <kees@kernel.org>, "Lama Kayal"
 <lkayal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, "Patrisious Haddad"
 <phaddad@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Raed Salem"
 <raeds@nvidia.com>, "Rahul Rameshbabu" <rrameshbabu@nvidia.com>, "Richard
 Gobert" <richardbgobert@gmail.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Shuah Khan" <shuah@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Stanislav Fomichev" <sdf.kernel@gmail.com>, "Willem de Bruijn"
 <willemb@google.com>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next V3 01/15] net/mlx5e: Generalize TC <-> IPsec
 mutual exclusion
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260903085215.3691657-1-tariqt@nvidia.com>
 <20260903085215.3691657-2-tariqt@nvidia.com>
In-Reply-To: <20260903085215.3691657-2-tariqt@nvidia.com>

On Thu Sep 3, 2026 at 4:52 AM EDT, Tariq Toukan wrote:
> -#ifdef CONFIG_MLX5_ESWITCH
> -static int mlx5e_ipsec_block_tc_offload(struct mlx5_core_dev *mdev)
> -{
> -	struct mlx5_eswitch *esw =3D mdev->priv.eswitch;
> -	int err =3D 0;
> -
> -	if (esw) {
> -		err =3D mlx5_esw_lock(esw);

This appears to the last caller of mlx5_esw_lock(), so the function will
be dead code after this patch.

> -		if (err)
> -			return err;
> -	}
> -
> -	if (mdev->num_block_ipsec) {
> -		err =3D -EBUSY;
> -		goto unlock;
> -	}
> -
> -	mdev->num_block_tc++;
> -
> -unlock:
> -	if (esw)
> -		mlx5_esw_unlock(esw);
> -
> -	return err;
> -}
