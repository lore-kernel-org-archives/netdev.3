Received: from mail-qv2-f10.google.com (mail-qv2-f10.google.com [74.125.230.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AB420479
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443420; cv=pass; b=etA8KUfKm6YReit8uKezeXr/piWWtrhUrqySh39WlJlPQML1hwNToXK9LLZ2Sc2JIeK0pYH/PHUYh+sVsfxFGF1ODHbk4FvcQjTCE2sYmChj+IgAUpyAUZJ/Cwp83hQMFijrxzNkZAjXjHKynOX0+KTyu529MR9L6OHa+EQChwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443420; c=relaxed/simple;
	bh=4CVOEsN+ekrhIpSwK3kSEvXDfTQ0l2LiKlcPXvJGXAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n83fVpyEbLh+x7cwuLC4ss/CW3XujrnT0DiabOWMlOkUefrjblySRHnkWcO/ISsMv9XUaOGFkWZhOslDiLpxxWO20SFoVU6D3LeJK0X9eeaxXlcTb7wXEUQGB3GVPSbNxidbNi9Gwx0deSd2LbTfGWA1xPvkeEYEgHOl3Vw2EFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLTUuGyt; arc=pass smtp.client-ip=74.125.230.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLTUuGyt"
Received: by mail-qv2-f10.google.com with SMTP id 6a1803df08f44-90e886b47d1so22440656d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789443418; cv=none;
        d=google.com; s=arc-20260327;
        b=eEiHb+Gn0971sPaZZq+fXftOiymVu/6x95S1J/ViNJl5u3Aq+n/VrUiKISKPvaYDH1
         39AWYSSwq2cZXFXynZbWsRHSM//RPa4O3EE9JZ+lMXoBfbaSIXcA5UWoNqAkKbvmg6ma
         yXmkapi0pMkE9ksE6BGLR1wy4c9PVszm625Asxp8+GQzxiHUBTjpuRBrjyhYEASykOuv
         yZi+SBOFJGm9VSlBOsQil3OoDM7ZI4nfxV7vY2098agC6YvXxXEdQDJphL23DA1eg2Tg
         OncVLPljpLS55U9clNGYXiGPU/hydrGwVYSZra1Q765t6QTQvFmNxNli8Um5XfzjEGD1
         2gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4CVOEsN+ekrhIpSwK3kSEvXDfTQ0l2LiKlcPXvJGXAQ=;
        fh=Rb/75riAKTBLksdsgLA3gyLtbFFYA69WHNZUVUBtGTk=;
        b=K5Yuua1Lhd9WjmxBxtsM8F5yuzE+IghQ7LUdjWF1nZny85zoNSs9LwrmQND+w5/I0C
         yULCJbyi3WQSVlyBLpRf6fsEOdJvJI/vrU1I+rmhHKcGUEMNClsiCRwlU7CKrp7xfo1Z
         FNYfSL2k4hoaKwjeX05m6ChPxu5ngyP0R0lVp9S4czpB0kHxEDlyiweEtlirkfl9ptJD
         drj/kN+f1ihltKQn3fsHq1FsL6TJXdIcXqUQztGqmyv5vAuyjwWcxRZ4HZ+ADt90FROI
         vl3L4FgzJHTYcEXlt2Fh0nHRsNqy018ytOzWwQ7wqZYSBoPEkyiZCxQ08ebgNZdj9NJ2
         TuLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789443418; x=1790048218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4CVOEsN+ekrhIpSwK3kSEvXDfTQ0l2LiKlcPXvJGXAQ=;
        b=aLTUuGytp/Ag6tGkToodk4igt6cEyww8Ri7KDx/kx0hsimRY53KFitYv3XAwvXA3PF
         SYXWjSxUK+rgL7J+HtWdroO+V/pUUpH+YeX/R5w8fC6EehHE4j25282gnfvdMW9MeqVo
         XdmaZcIdo5fjsR4cYOxqgulkWhQLSmokqr1OSUz+Hw5fLt7ku9tvaadEjLFCfdYQJ9cm
         FBxNMff66Cvfy6aODNF5IF6NAOj9gWoMkx4B0UcvGNJroREif0RmZHxHWGUZ4A9IAT8P
         BSbzJaLSaeIbcGyQ9OB90rHK5EMkhY6CJCefgMaUuy4BxrqNNcA7T6LywZKgh2EyAqaA
         sn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789443418; x=1790048218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CVOEsN+ekrhIpSwK3kSEvXDfTQ0l2LiKlcPXvJGXAQ=;
        b=Hkg2XTGX9XNAYCwbJd9uUSBSZruOg54KfQ32H4PRbPuyF5RGyoyA6rPCslaH69ty3h
         ZxwhEB8I04QMjR93ZvLoKHR1ZfcawXSpOW4kUEwrVqds7+saB1G7G4ordKQVuWbCv9Pl
         kG/9XPv/0j/4yP/0MxmbcdvDzF1ticZty+8Fm9ZgYVCO0F52IAre2PgiVmZ1CC/h1NVo
         AqfpWaVN8B8B1NCJmBdnUGhxagvSdhbK26haOTytdyuev5Vz+hwALyEzJws+GLJ3hUHJ
         tf7ihsEtIqbx47v+9kWwzYiIXM2fZNW9KLk290WP1iVajGgh2EucwWuMiN9iQXuff75E
         MxBw==
X-Forwarded-Encrypted: i=1; AKwUvBz1x0n8K1ai4B8aunY/lDTXURIrvf/lwVew1b7rnqTGVF9z6WIA9F4NRmhdRJY7UOSudthzJtM=@vger.kernel.org
X-Gm-Message-State: AFuF++ms6lvdpV3YCi9w2/ggwle6Wtu5nsnssibpZkiOtxdLgH89Sm42
	ryrnw5MhBCHfY9UsAKv/LvO+32bbmpucVcgycBLRuZQY6yVI5iJj/8HxVKJ1t/16GVcusxmN8J/
	SAS0Ios4JeksrzoLvOAiEA2hZezXZndM=
X-Gm-Gg: AYBFou09RkJCpcVGgb2EV/H1+Q6qt8Y9tCdd3Mp+A7w0rPgCuQ8PjxRohZXUms33Hlo
	6GWrMsqldMGLRuV/GQ3qn/yVFf3t+rdb/I+Rel/D8ijFt0XstatkSeHvojk2aQj80Y1GW8MOton
	DZBqp4sChHq+QOvTn1itBHto6GzeLvskO8v4wI1wE7Rr5sC5LtJYi3agdLfFYloqCJbo6HDAnc9
	O2O3TYf7qQA5MKhajbKXdEppcLWXMwIRANfcX0waoM6q0YsJprSn9oikvRaEMj7P5iNWFFpFO7y
	6CwksrshqeY3aesqM35Rb+Pm6ofW9lOneVNq/SBiq+TUjjf9pe70pdP4CHzPbpC/7RjQLUlXP3T
	9UbtGI9/XpfGUq04oQQ5WUf4/BUbMsuJEy1cNnSpwDDaJ3ADhtk0=
X-Received: by 2002:a05:6214:1ccb:b0:910:4402:f410 with SMTP id
 6a1803df08f44-9122e4f648cmr95106786d6.13.1789443417849; Mon, 14 Sep 2026
 20:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915024638.198865-1-enelsonmoore@gmail.com>
In-Reply-To: <20260915024638.198865-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 14 Sep 2026 20:36:45 -0700
X-Gm-Features: AcwNN1VxvTTwmjYiuI7MUBdmincRx1V6o-gOmEsE58_V_amGm6-KwI0PkQn9_kY
Message-ID: <CADkSEUg2mgF6mB12uRi5605Mb0MTN=R5GF5FyrOcuyNVTc5H9w@mail.gmail.com>
Subject: Re: [PATCH] net: fealnx: remove never-true 486 CPU check
To: Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Michael Grzeschik <mgr@kernel.org>, Denis Benato <benato.denis96@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jijie Shao <shaojijie@huawei.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:46=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The fealnx driver contains a check for boot_cpu_data.x86 <=3D 4.
> This field encodes the x86 generation (3 =3D 386, 4 =3D 486, etc).
> Therefore, since 486 support was removed from the kernel in commit
> 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
> condition is always true. Remove the check.

Oops, never true*. Should I send a v2, or will whoever merges this fix it?
