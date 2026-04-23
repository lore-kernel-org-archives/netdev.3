Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B83ED5C0
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947951; cv=none; b=XBvTYVNeSq97EmlWtHR+FVxDck/kVQQPudcb8yM6mMogUpl5QZlmOL+U960+Ze781S5YjrRdOUXQsihSZDsof9pi5XROK7wjqgjoalpRw1CZvDC+nve2Ci6Q89qwOPtnbXUVs1v7s2GWswbHeFLhsuCLAtQXzSewo6ZDH6Nx7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947951; c=relaxed/simple;
	bh=+PJtUnUqMtakfpoukgNG6m5r2Kukgd+onZ0KysLCIY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUE5HdqzB3//qJDAa9RBT2ELZKolesmx/upRjB5X4LAQUxhqQAP2FjnDfkm0qEnRSntN6zzaUO0SzrgSbfq3cJXHuJiVEMZk1Wm0YQOHElg0SJM5QfsiX0Gy7yYu5LjQtXMUW7hihT8J6Be0TSEou2O3J8nRIvVCsWaP/2Dv55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKtjlTrn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKtjlTrn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2429f98d0so38710535ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776947950; x=1777552750; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+PJtUnUqMtakfpoukgNG6m5r2Kukgd+onZ0KysLCIY4=;
        b=XKtjlTrnsNFk9qC8X4h046n56xZMNW8P+PeaXDazHE7N2XtW378qZBn5pzzaDJeDXS
         7WL/zR7RGF4LsQenGqK/Q/7rGA2K3DjvmJ1w8qi+3Pipv6K/1Qb9iAHJnjUOArpACmXf
         gKFlUk0bZSH0S//2GCL/dQ/kI8Ml0FxgitVcFRGNdOcwuEJq/1hzAcOCIA+ouXIDu8ru
         dL2rq2q6aNIfblVkL3Kn5vmzRvcZq9GYU6TqaVyta9saSDIK8jZJMIdRaKDRlmo6K6pE
         o3JTHO9k1TlL89Ss3VrcNY7jsfYRbqBbr2cv+fLAoKdXNtB4a3y8mFY7hMRJzE6busAj
         sM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947950; x=1777552750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PJtUnUqMtakfpoukgNG6m5r2Kukgd+onZ0KysLCIY4=;
        b=KcbQdi3hiMbh5ArCk8uvk7LBGNs7eZLp/jygSuJxK2AaDCc0gT8NoTQiiI6fsCO/8B
         tK+3JKpd5Cw7wvFgl9ykoUzp9MXMZEUYhvitz17bNyEYiCiGS11aqz1TNWsnjZTf+HzV
         uYxBj4H5VVniOiod7ssSh2qUqdNtHmeCXvjGM7u+v066izAn8w5TLstAwhy8E1P+wJ1m
         RabLu9rKcdLStgWIE/NU9zF6GfAwgCYdE31xPg2iXXIVFu3MmeRJY+gPpM3sCGeM4UvM
         m8QPzs+Ez7JuCqCpeAeaPhdK8mVc5XH//xduyAwy4d52aZyJPXuxCFY7u4NCMtZrFvRg
         lUig==
X-Forwarded-Encrypted: i=1; AFNElJ8dN9LnH2SIem6itrf2lvwujrbaJx0PSN0aSexs1BB9hLeL+HKI8f8HZMrW0fVFay4MV5BZWGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2LshnLyOJPGg7VwbX3fsNmoovDORTh84rVcesbN2n2rWoof7
	fJcfBfkzNrTle+fd0dp2nhOZic9dlEFWyrKjZzRj2By3WzuFZh0LeGuQ
X-Gm-Gg: AeBDieu3grINo6ui42khbsvVffWPQVISsLAD7JtsnBRctHufuZvsn78oEAAULHk4P5+
	7oz+Ith6H10ZGZr4sfQrlu/k06hNxQclWV8bcVxjY4t7hDzCfdn4muYBnhWrFDx8mfE3dMvBlJB
	+wza2aZQkG4dflU6WDxBj6DxgOrP7Ffl0/Iibzzc1rFpLx44LEeLxJ/1Mq3ufSfIm01Tcp1qbq4
	khVonethcbyDNL7TTfJncV98YDIY09OPpF7bDI1V2eAi4ou04l0SBjfQDAygGhckCBNR2F2EZ6Z
	pfBNpfz6vW89G1ifzFM2AIsWVED0MJjr7C2pRyLsGipIXlw/kLk0jLQZUURI0C27ha+SAgG5XgY
	Sih2BL2NiGDnKdheaiI+0lAJ25EQPoPMN8jqLT0yupq7ZhT+mB4BtQzqhLQQM7+4SikkmjJhv2Q
	QMZsDAyFQnjbzE/R+XImabN0y2fjFfUhHVt1unIw==
X-Received: by 2002:a17:903:17c5:b0:2b7:a08d:9e42 with SMTP id d9443c01a7336-2b7a08d9f73mr34404275ad.32.1776947950067;
        Thu, 23 Apr 2026 05:39:10 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c4fsm243138035ad.59.2026.04.23.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:39:08 -0700 (PDT)
Message-ID: <c646167562e802438abc72435f126c6bc7263ec1.camel@gmail.com>
Subject: Re: [PATCH v2] mptcp: do not drop partial packets
From: Shardul Bankar <shardulsb08@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, pabeni@redhat.com, 
	martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev,  linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com
Date: Thu, 23 Apr 2026 18:09:03 +0530
In-Reply-To: <88096a1b-0c16-40ae-a03a-0d0d7f1702a4@kernel.org>
References: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
	 <88096a1b-0c16-40ae-a03a-0d0d7f1702a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-22 at 19:03 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
> On 22/04/2026 16:39, Shardul Bankar wrote:
> >=20
>=20
> Thank you for the v2.
>=20
> I didn't review it (yet), but just to let you know that there are
> some
> rules on Netdev [1] (that usually also applied on MPTCP side), and an
> important one is:
>=20
> =C2=A0- don't repost your patches within one 24h period
>=20
> Each version generates a lot of emails that are sent and need to be
> triaged. With the high volume, it is then harder for us to follow,
> plus
> a lot of shared resources are used, etc.
>=20
> One last thing, because this patch is not an urgent fix, do you mind
> sending new versions only the to MPTCP ML: to a restricted number of
> people for the first versions, there is enough traffic on Netdev.
>=20
> [1] https://docs.kernel.org/process/maintainer-netdev.html
>=20
> > A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
> > drop partial packets"), reverted in commit bf39160c4218 ("Revert
>=20
> Note: these two commits should not be mentioned here, they have only
> been applied to the MPTCP tree, but not upstreamed. Instead, please
> use
> lore links, e.g.
>=20
> https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.17630750=
56.git.pabeni@redhat.com
>=20
> > "mptcp: do not drop partial packets"")) also added a zero-window
> > check and changed rcv_wnd_sent initialization, which caused test
> > regressions.=C2=A0 This version addresses only the partial packet
> > handling
> > without modifying receive window accounting.
> >=20
> > Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order
> > queue.")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
> > Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
>=20
> Checkpatch is complaining that the author of the patch is not the
> same
> as the one who sent the patch; You probably need to run this command
> to
> fix it:
>=20
> =C2=A0 git commit --amend --reset-author
>=20
> (when the patch is sent, `git format-patch` will add a second From:
> tag)
>=20
> Cheers,
> Matt

Hi Matthieu,

Thanks for the pointers. I'll wait for your code review and address the
process feedback (recipient list, commit message, email mismatch) along
with any code comments together in v3.

Regards,
Shardul
