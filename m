Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1A1EFF93
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788582563; cv=pass; b=WfVdeWww9/NEK6QXprBpSa8OJaDJb0CpZI/X33iNNX/1wa1KKqyx+vKZP6DjLPAtGM2fkJHOZYLcSNLiITT/aVu9Zs10/8ARnp0hPa4GheIJkGoePRHBnGlkFsTQJsYHe2qeMILu+v3Z+K7aSX6IEXanRLSohmhiHnk3F0bnqjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788582563; c=relaxed/simple;
	bh=lRvPZ97YMyvoayYLe4R+1KZ+I+1bpLkH2rwlOA+IOto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMtdL60O8JXFPafbK4hH35Dc/Bnfxgm4eAm9JO24vXP6y5xLMGpCdj/0fRUcPjaFyx6Fzezu7GytN/ULcG3JTMa1MyvEz1RUbNOBP+oQhIRZ+8NbTras92VmyUYRz+ctGfwAojOR15ykgP2qxEoVtGOspCN9MpkfPeGQo0A6Pxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJ+TuwcT; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJ+TuwcT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1379823a91.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788582562; cv=none;
        d=google.com; s=arc-20260327;
        b=CwDj1DMS029UXK6wzW/+3rqOsI1wynBUrNfNRt5lraNfqcz0Av72Rn9jAWHO9wo/Qp
         PhsIxpNh315swrv6pqnDWY6RMQC6UlMn+LwzO2L1zM9RdEHY98XmUd+Od6VZMm9x5MXp
         5H7Zo3rnj/cqVNu73NsbF0q2EGWd6itk9nghRGfgAomtUehnqQ+VjRJlH4+zbjhERvUz
         F/OmWfoWIPC7IXOpPumJUgxM3824y7bt3AsTnUC9h9oYG0WGaL3Fe4hfzkiB5j6b8eeB
         f+jr7efs4E5sTLV3mWj88lGhrUF9q45U8M+As/HTf8CzCrzja4CB5te10QXxViWejd6p
         lKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lRvPZ97YMyvoayYLe4R+1KZ+I+1bpLkH2rwlOA+IOto=;
        fh=Wn/zDirr7JILIYakvM87JrAhm2OBoHSjtwU2hOUaJcM=;
        b=McJ9n/JDvBHn0ChPUBTnYZButGN5s6MpqQVkCDAQVRGCS2b8sAWysNGU5OPVBaUkKE
         OEwGbCptLFeMMj0K5XeTTYXjeuYCDim01O/4EgQsjB0WDPmr5J+Ahppxw8ZOZk9RW/vc
         A6nH9xG+NzjhMqcGtl53vVxBCDIHhWcd0TbO5fJ6hb4ZOwhBWFC12zUoS/Rm4aj8fesU
         wiBol77Y8UQaSXWrn0f8lyJB2AX1U5NJ+1l4k++srK8MJV6BjEe498IFvyCLWglNiTFB
         QSehhDk66fFUYaMBKnqJDR57ts+6ZDxVhXn2GwCpvkq2d9Vx0xgHj6Jz4U+ZvI3h0FbM
         a1+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788582562; x=1789187362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lRvPZ97YMyvoayYLe4R+1KZ+I+1bpLkH2rwlOA+IOto=;
        b=DJ+TuwcTizZAZkWMqwJJf91vJ5CZn1+jwZAaipaza1mDwJ0+j74zZ+hyOcLBMZdIQA
         rDgjMD6gJ1Ya1fqmlTu21HNJrgQggn5fj9QQyLnDs/iYA3mv7E3WaBhr5FxHLXJQ/0V8
         27Fb8EiwxZEtUFwu+WRb6Jup1yNkfghczc2seTSzNmz8qK9w4cWGFNmoPvpCYYKJUgyA
         rh42DCpw6/JAT7rwQVKzfSDcbhrSlf41rsZObksDvzN0+Hr9Iezb7uHjQPcKOywhwOOq
         pT5I5jx63EVDHx25IdGtOLnWYOizcX8NWobp06QMWOdnsXBtI4mgwJhdxNfnNykWAzLE
         ZT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788582562; x=1789187362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRvPZ97YMyvoayYLe4R+1KZ+I+1bpLkH2rwlOA+IOto=;
        b=tEX7U9AgaKUtSjUfdJT2OaNjnVTFXJoA+aWfxkyFSK7GWNBAb3ybQG1XXqSrcfy/kn
         ULGDpKRkoTwfjvMRw6tXVzAwG+J36znhruN/DgNymmuAD+VClduTRE51u/eiEsm/AnXn
         S8Q3llVS0vevwlth4WAfQK8dJOAOahk9gjmYYj39qF8ImK5kj1ZBS2rJO6JW5Qm1j2sq
         eAImh5aNXshUwgSZHKhR7Fn+IayPWSB+coljHLm88dO6OIOALrKAnCi+v09l6KX01isP
         m1aStfFI5HK/BusSdZaHaNgb0v3Kwoq80lYwjCVh95UdPxOlZ1fSPDJWVktbOM56g9mE
         c5Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxL47XHsShRbpiycEQVwHN/1Czxmgm/QIq2Ox2CTK8+IsCsZA7orTOPyLG7o/uXFdZhA1V+rV0=@vger.kernel.org
X-Gm-Message-State: AFuF++nY/aPkfY4wVMObHwRvuY6tenx6vOeAEVj3ou1BJ3oIliT4qFhc
	VxZN8b+iHDi0thnXsJwXqSWWZm3vnPLO5trIk8SzQ7R1/CFzyrJSKLlCjH1TXyyTkpDhCrTfW3M
	g+kBZ1Pqq4L6cN0KJ9Cas5catxosg1OOLegG0SfHI
X-Gm-Gg: AYBFou373mVj+t6ThnfmlY1qJePlnPVWhPGHh+Agg77WJTjkGuIXF6kZXxDkKRGO/Nm
	zXJ7gx+LvSTLEps28oIarHniD7ybGTv3j47BBopF429pcnTk3EHPhtVP3SRbhXpVzjmqWa3UkWS
	Xi3YbXnlAf4KSU+f4JHTO1v5zbDBRI2X4JonzhXOvG/GiXafKEc/pVJq1+7QnrS7hX8Pz0mRe+u
	XHMPekTW4MHxtRyVxq2ghxSPJIGNFyIwEyULwo0wgCWW2GhtijyEbqgi0FPf4WXYfywu3zw5nPk
	zdE9KBQq+orneS0X2mfshefJxXtaes8G1PHI2bEysXVNqg42q6QI9RveqBAufMwZ2b2x0G0UY6u
	c1x1qYdWoEQ1a5PNM318dC3iRuGkXNTp1U7+vL7+89UZJGx9UMYNO4f5nlXo5O2mwxmZVelBB2e
	ZuaS4KG6aHsQF9
X-Received: by 2002:a17:90b:2b4e:b0:398:9be9:ab8f with SMTP id
 98e67ed59e1d1-39b2622b9ecmr15420388a91.20.1788582561379; Fri, 04 Sep 2026
 21:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-7-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:29:10 -0700
X-Gm-Features: AcwNN1XspWhWbA520kNqcXpR5XB3VbUhtgZxKXsD0AzvzJ-niVug_2ftsKShvlE
Message-ID: <CAAVpQUDuZO23itaxDBxXtMbHGBZVrnJ6z28mm763zkh8Os6O-w@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] vxlan: dynamically allocate struct vxlan_config
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Move 'struct vxlan_config' from an embedded structure inside
> 'struct vxlan_dev' to a dynamically allocated pointer 'vxlan->cfg'.
>
> Updating configuration via vxlan_changelink() or vxlan_dev_configure()
> now allocates a new struct vxlan_config and frees the previous one.
>
> This prepares the ground for converting vxlan->cfg to RCU protection
> in the following patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
