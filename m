Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D0354AEB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732274; cv=pass; b=TQuek10CfgmHxjExKLN/TP/xmfrOtcHbRNsWQhtN7wkMmZ+3DwZYwGODrtKJWNcKOIBF89cjUlk9U2McVqulXE/Y4LVCBKC9fJn4dgPUm1XVW9534lh2rxsM4fCb68XCqW98Oo4kNkYJCwwxt35t10UvXa9m9iIt8TIosS9l6F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732274; c=relaxed/simple;
	bh=bhJUcLjKo02bLvE25E0PNpH+ye50aBQvEKX0dR+Ok7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mbg0Cx60gDvd2xjRJE5PYaOQ3IDXII26q4po+lNudcLWnDZAY9rEcJ1qzPT54XmLhjkmdbd2LbYWoMRL0e+zGLLUg8BwmR3NK+OxSW5YxfDKSZs62DZoDJ4nGHa5hOhcsB23KbZDpQWNnT5tIoCYgq9lGP1T9lGRYMB+YH/B1jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RdpTagca; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RdpTagca"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so40650195ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790732270; cv=none;
        d=google.com; s=arc-20260327;
        b=qGxgzXfLULKfgQvr5DaxDgVHmpXDQYDs4VSdNQRNIkqhb/hSEfX6nOVBHjOlvFhP1+
         5iw6mzX/aOC9FlYDizHSyUD+WrqoZIFE88LkRdIgsdf9RO06xJ0l9WzLrQ6Qav9F0q/Q
         aQNcsGhx8EchLSieT8wVyhWFfqUPwTiELcu4KFgrfhwixvBHYZze1HK+On3mamnUw4Sr
         n1x3MQurYtM0/+Ao+pj9RVC0UV+kBeSVssAj30nULBvK79zt+azqdWqIrx/F0zbjRr81
         GIPpd+HxuBFsRH0OIgYiqMsNiDh05vwF9Gw2VT5MSTCMAwy3TEX2goONJuxLGQUkFROs
         DmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OaTWYjGa88IT1G2tVr2iEi35Jf6xhHPNQWrE7gJBkU0=;
        fh=8yuySyJv98qnoIfa2kMIoN40WbzJSHiCODl8YkxkRGU=;
        b=fKp7ZIOXF/S60tweYbJ8IIpCiCvFgJc2TCCnJQE8bEz3ZQ6G5QurkS08PNqfZsRDZW
         yKLAewuWSuOmALu0WrH3xLUCD/W37nlyX2C+JGyAKTwRVJNAAtrpVVxDexqeP25zoXCL
         VmzoKbP1vEeThoJm5LyNQFOhFd4SOygO3anG3Eq59LrkU0poqvXgG8FFARw75KLixpwh
         QdXbsXGGMt9sLqYazLzbVDoh0ewXmH7wsOTn5gg1z2+C95F1qucY1TSMLwIQgoPMw7Kk
         bm8Hsxg3z9bcS1f+LrvtKDFEbsU5/PCAfR5sfG2fcyhSgJ8PjnIQzpCrr0q42zmH13y6
         cFUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790732270; x=1791337070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaTWYjGa88IT1G2tVr2iEi35Jf6xhHPNQWrE7gJBkU0=;
        b=RdpTagca5oqL6pDvOimlsuFD0GSLSAFqbbOw2ZCrUVpE4+ZZs8Jv0AktvcPDWd7cPp
         U7VpEv/HyAiUOvftRvd6tmyE6mqZiGPqh/7qcAuuVNt5WKpYyeV3n0XAbotBdU8HRDdT
         SlxR2wkc6gKRaZPWiGHAhFrqDDMTE1ZjryYu2CS874oyITZH9evBI3gRQk8cEP27xFsW
         kcXNznVpJdi30j4PccmSBHBS9m/Db5wNSn+GDioRmXKIvBMxfNdCx3ZkXZvOTwcLigYO
         FVCGJJCMGN57cvhQvGlvLPDWGDlUNiHQQ0JMZTdt1gbgpGHi2AGwUOok8JaIeFkiuujk
         i2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790732270; x=1791337070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaTWYjGa88IT1G2tVr2iEi35Jf6xhHPNQWrE7gJBkU0=;
        b=Wr5Zoyt1eXyF0F+4ZFBt5H+6zrKM8Jc1/YmbROKVrwy5BlXI31NrUcifmNW0ME1DaD
         K/aBk02ha4fskb9L8Za6JtZV3OJ1Zvq0ih5x3RJ6HX2HEmPyTGKP6CS7wH37gAfaAGMV
         aTTJkkJL9DNU9l5k+k7KsoDb/+37KR8a7Pq0mXsXhAUMHQKNK1ddBE6HLzPuz0osTnoM
         JZS1bskAJd4yLlExf8ENI6O3O+sFcne68VyauIB9eEAoEMM7jstjZtsLA6XwO50uWfBO
         T+REnbtx27uwKjBVIvIYY3tDmpuVefh9fbr423YIK5gWCtXzCd7rehakUbwnlYXz4OhX
         GSWg==
X-Gm-Message-State: AFq9FYLY6PbQ1tBx5J4CLIdsjmfTV6viYkvWirpVPKJ/sEZFjgMhgVbu
	BnKk78+xkSPEoZJqfAoV41lUGEIOF+DGT9odEBYSp8CGyGwY5yTTuHIS4t3MRwyEyXcKOL5BTNf
	7fTp2OVs8T20MN4wK6W3NYE1/xFA15UCgM2rFQZqh
X-Gm-Gg: AYBFou3L64aVtslI4RmgbRxBOJliX2sipV6CRdafLicVYQKpNvvwu8hPTqWMNJFZ5pD
	Dd8/7QF40eqVxYiw0B5M2BfOQnfH90RyOb9sfrAlm0ZpFT3tUVUGS3fPNy6Gf1StR92/3uCnXhQ
	ORL9TQ0okJC2J1WIp4qKrQaRKbPUlO8+EZA7xGGo2mCzgU+n9afTmQfPYTQePBuTu2WS5yCHoWA
	HzwHoNWArsiGAkyt3xtY8IK0sqmWD/rZRS7PZr1G/nd/v9PWDr16aFPRn2Ppc+/defACkK3tSVd
	lh6P8Aam4NlwbReUgZvWf/uIYdrcq6AOLJcp1Sy3xUrALLylyumvudjIqOdo8s7ZmyW6ESbTXu+
	tSXg9ED0/CFA=
X-Received: by 2002:a17:90b:5826:b0:3a4:b418:94ce with SMTP id
 98e67ed59e1d1-3a4bfad5481mr925945a91.1.1790732270586; Tue, 29 Sep 2026
 18:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928193046.6698-1-fmancera@suse.de> <20260928193046.6698-16-fmancera@suse.de>
In-Reply-To: <20260928193046.6698-16-fmancera@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 21:37:37 -0400
X-Gm-Features: AclHuK9OxXVVrbvz3Zo4XSmKnOU38tEex0LOM5rHmx7snd46dBYW9kvi1MOOmgw
Message-ID: <CAHC9VhSQe27X+YVp4crJYhH_OxeVt=G6HCyrOqJgDii=MiCXsQ@mail.gmail.com>
Subject: Re: [PATCH 15/16 net-next v2] netlabel: cipso: introduce CONFIG_CIPSO
 to decouple IPv4 dependency
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Florian Westphal <fw@strlen.de>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Joel Granados <joel.granados@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:32=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Currently, the Commercial IP Security Option (CIPSO) is unconditionally
> tied to CONFIG_NETLABEL. Because CIPSO is inherently an IPv4 protocol
> feature, this creates a transitive dependency where subsystems relying
> on NetLabel (such as Smack) are forced to depend on CONFIG_IPV4, even if
> the user only wants to utilize IPv6/CALIPSO.
>
> This patch introduces a new CONFIG_CIPSO boolean that is automatically
> enabled only when both NETLABEL and IPV4 are selected. It abstracts the
> CIPSO-specific Makefile targets, sysctls, and kernel APIs behind this
> new config.
>
> By safely stubbing out the CIPSO netlabel_kapi functions to return
> -ENOSYS when disabled, this allows NetLabel and Smack to be successfully
> built and used on IPv6-only kernels.
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  include/net/cipso_ipv4.h         | 18 +++++++++++-------
>  net/Kconfig                      |  3 ---
>  net/ipv4/Makefile                |  2 +-
>  net/ipv4/sysctl_net_ipv4.c       |  4 ++--
>  net/netlabel/Kconfig             |  4 ++++
>  net/netlabel/Makefile            |  2 +-
>  net/netlabel/netlabel_cipso_v4.h |  7 +++++++
>  net/netlabel/netlabel_kapi.c     |  3 +++
>  security/smack/Kconfig           |  1 -
>  9 files changed, 29 insertions(+), 15 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
