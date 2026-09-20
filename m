Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EE1FF7C7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866340; cv=pass; b=DnmMLIon5TrZARP5DVUKXrjKrarOYZA52XwatOJ0ZNc3TbQ31ozw2HOlJ/XwT4ulgBGxNpO49iNrgnXjsE3T0Mbc/g7P34uTDMWnKbOhD4vjrvxN5u6pB1Q4KFmgSfMGlcE5eqgDDApqTyXQvmhh+ZCYY1KGfP2ucPWa+AI4AbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866340; c=relaxed/simple;
	bh=9Cl8MzOpqM4J6On4kxqgKOwRQOeDSnW9VyXB1VHn/7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPk2saBbEyhrV+OqMuxQvGAFhGAMKu6klMsXyMDEpGaZEklafkT9YmHsW/lc8vKQlepXXwpqRSqKTCE2apE1QQ08vpeEYFrCdO7QTj6VgksYMMU1G+Nh3qjOpV5EjvM/gSV6mWvxkPO6XgIjZ2JR6Cw+58EzbdVQu+//e+21Xaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEIkRrMr; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEIkRrMr"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so117990266b.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 18:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789866337; cv=none;
        d=google.com; s=arc-20260327;
        b=M9HTzTl1JKbkaEej4ZHZweszcahZQh/bdyyEJnl7KiwmnMeEb52jY/CjkiSELNmn0z
         +PaP9ZofdIF7INXdd7VKBY8wrMhVcx9AFnSs9KBSh4N5hQUFnW/wpRoODTxjyCqyBJuF
         1dPHsk6y2PCenBAEuHrP/XR2NtWhQS6YbL40umkjxhwg9nZQFVBT+6ZskFGpe0i06D/f
         uqvyVT3DR/xpydqIVuGubHYOfPc5E0B5l7nAh1ySWjU9HTrvStaS+adWXdKxBUcnSlDA
         elMxumBkrQNAsUZLhDka8OsrQAG6IXjg4KukqJ+M/PFfZRXw+ZML4MDADeqiXkuoIh8p
         y/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Cl8MzOpqM4J6On4kxqgKOwRQOeDSnW9VyXB1VHn/7s=;
        fh=Z5+Vc9/xcNutHz11kuQyBgxHpJdBy94Bzh7b3CXsJ3s=;
        b=SIy2ExP+5mjwU6/XYLw1udkPQtG7Tgwbqmz+E/lMwitGMruiwMCXBMv9ROCZERaVmS
         JGzBI09pkLqazGHAz4B1P+UsnjMIqoxCO4HSPYTj+yPpAd2oDOitJL1Wz7TObxjyja0I
         qPX8RVRt61fy+JwsH3aTegr/WvLgnrMqwZI48lCOCiu4epmBDEtXRYyUFw/rVnWQ9u/s
         PRrhiFTsPpBtBfE4Tj1mknvffw5MYGvoZUH7H/7rrH+JJavzL2FFp421BBypbgcA+okX
         i7ltmK47DCZtIpPJHlY5Dw9Vr3KGsIDLWzQQOa5jhTMoUBJlnJy8iRAFs7DeVtV6gc1p
         RbCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789866337; x=1790471137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Cl8MzOpqM4J6On4kxqgKOwRQOeDSnW9VyXB1VHn/7s=;
        b=WEIkRrMr1kTjROhNQo4itlGjaxu5jZv1u3OviUO71+jRlgZowfS5k80ipfr+4ao4Zz
         3Tr6efn5zQgWGb/oaJaaT+N54JQBh2MPY6BFs+tn4CqQjc/k4g/jnCuAAMT62E7xKUCn
         2fhwheC0Jp3k8c3na4ciLkX7ADHYkdvp7MlL06FlgZu1aFY2LXfmVsN24tiQAc1oJlXE
         PE2dJW6Hxl6UBcscIgN1o699il7bkT6BMSlnCMPofbN2uYk+8wt4VaQkXC2U15dZ92ov
         MuAonuMprppQbMfKRJQdtz7TEW8lRRTsscvxIAJ3tFjhV3yq9/lJkzUUIlTzCEnJg+3C
         DQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789866337; x=1790471137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Cl8MzOpqM4J6On4kxqgKOwRQOeDSnW9VyXB1VHn/7s=;
        b=OF5bXyqGQc2iKYmsX6v7HU9i2hrqIsnbUwRGyXiJQ8V7SVJCU4dl5u3fU/EDMv7WdZ
         z0GoxtVWv3mUcVOdjwDzMVtZu91Hg3aw91fszo0573acqoDInmcY5mtMFLoTz4JBRFMQ
         rohly+sRGNSZBFw5GsLqjy3Focn155yaerZdyHDQBGlyAf1pZ61P43C+rBR8HUCpjv2t
         SlfsuAi2DSRufU7WtAr167zyoXpF1K83Aoct6M6MGw3wQxbUILMr/Gp8os81x9QnWlUO
         jxyJhUzR5Y/5ROXVXYz7C8gt+3PrLszx2l+tUI+qbxl2j8ZKrqwDOM7D3xJy2/kx3fPa
         7WAw==
X-Gm-Message-State: AFuF++l8YsaUjykZ3WFscRkmxW2pwciXcg7KhQWN0w6EQeQl/qr5nK6D
	7xU0BiR0dH3ixKa4O9wrfURuYdlEMhFElA674vIn8k0+B+MW1fCqhEdZXcG4VR3mED/W0xLVEYS
	9M3jbtaPKCO0Buni/oQcx2AQXfwu4K5E=
X-Gm-Gg: AYBFou27CwtM5KtvL7zjA3meCIseNlpwD1xae8tYfi94PfnZcJQs+BDEtL7Q+M+04VT
	Bq05Rin0/7iivZRvxTLyQJDGrcUsGZ2Uj9Cq4uwvM4qCSbmFYXALacosfxe4yducN8fXsxJy5pz
	eCZ+ECbkE8kV4aRkq1GpgclZBThmbxJWkjZZ72eTMFRzI3ElINrfbUomlzUe8Wav8Lv+6ia6aVt
	EwW6iu7uElKoShruS0fuNYwK7nBVRt4L97FmMyXC6GRO+gm9oBUtFbiT3Hle+HfxHECNn9NU3Ug
	eLqfvcGA73iFdpFlJ0WDBUr3ukipy2Zow8U6Waya1rMdch4Ep0VmqEaZiSxE4l3HwxqITF9O3jb
	ijrLj6RdpHGS07GCTFMVO6eSJPrOEMEzpqK9dgNyPUi5YtG4/VKRGuQdRtF9UzugV5S6TtqfzSJ
	IhiCoI6jeTVOj1Da2oGMyhayR4zaf44gus4FAG1UfHCVG77OELRk/sQYqX1FYj3z7+sw==
X-Received: by 2002:a17:906:2099:b0:c29:c575:de84 with SMTP id
 a640c23a62f3a-c2a164422b2mr369770066b.8.1789866337249; Sat, 19 Sep 2026
 18:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914212409.74539-1-rosenp@gmail.com> <20260919154133.3fd41455@kernel.org>
In-Reply-To: <20260919154133.3fd41455@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 19 Sep 2026 18:05:25 -0700
X-Gm-Features: AcwNN1WQnD1iBFmCVfW9pDJM-KDqAYyCx3hOiVJ0-12Jxjp3COQ2VYVvEI3MBjY
Message-ID: <CAKxU2N-aWS0hNFbirG9g+vzz=KEDHvr5Hi1gij531OXT-3Y0zQ@mail.gmail.com>
Subject: Re: [PATCHv2 net] net: phy: marvell: undo WoL setup when Wake-on-LAN
 is disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Michael Stapelberg <michael@stapelberg.de>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 3:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 14 Sep 2026 14:24:09 -0700 Rosen Penev wrote:
> > Fully disabling Wake-on-LAN on the 88E1318S/88E1510 used to leave
> > the WoL interrupt enable bit (CSIER.WOL_EIE) set and LED[2]
> > configured as the INTn pin. A magic packet arriving after "wol d"
> > would still assert INTn, and a later "wol g" re-enabled WoL from a
> > dirty register state.
> >
> > Fully disabling WoL clears CSIER.WOL_EIE on the copper page. The
> > LED[2]/INTn pin mux is disposed of only when this driver forced it to
> > the INTn function: the INTn enable and polarity bits read at arming
> > time are saved, and restored once all WoL options are cleared, so PHYs
> > serving the MAC interrupt, strap configs, or marvell,reg-init values
> > are never touched. The FORCE_INT bit is not set while disposing of the
> > pin: it holds the interrupt line asserted and turns the shared PHY
> > interrupt into a "nobody cared" IRQ storm when the PHY interrupt is in
> > use.
>
> Oof, this is pretty hard to read. The paragraph is pretty much 2
> run-on sentences.
I'll get it to rewrite.
>
> Please add info about how the issue was discovered and how it was
> tested. If you don't have HW back to net-next without Fixes it goes.
> The AI is pretty bad at judging severity, I need to find time to tune
> the Fixes suggestions further :/
Probably. I don't know much about the specifics of Sashiko.

This patch was split from a larger one that adds support for WoL on an
mvebu device. LLM suggested the v1 of this as a bug fix. I did not.
But then sashiko did.

The full thing, which unfortunately needs patching of the PHY and GPIO
drivers, along with dts, was tested on a Helios 4. This alone does not
add support for anything but does prevent the IRQ storm as mentioned
in the description.
> --
> pw-bot: cr
