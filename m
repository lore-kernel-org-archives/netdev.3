Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CF4CE690
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997664; cv=pass; b=UuF0BWE6rNaJu3tE4w87a+EbqgmCpH2VZDN8uRwdP6wyvwpQPBdIMh1KxcwwofOlBna7ZqCdcqVq2IEHSmEEAEEbl9NAs/6BY3iv+KHctO5gVsHHMKwmVPH3qLe7nNp0+/e5T1cDIDEivBVMvhbyxV7MSTg1asWPsFKhbQGVba4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997664; c=relaxed/simple;
	bh=mqlHJeBfyTwlYUc3NbiaMm0Dt0eUNRbSZnH5mzrwXDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEU5/PW/i705BiTGQRXCObC15i9R3xAo78l0FbDuPeIjNaAO6Uv7Ke3Qd1HCMOsARRdpEnIWd9eDlAf2rmQRGB6PjP0hqcvJXuzs08vAVGosFCl33EO97DCroJXv+EPLoE3sp4IATFbykAkfSYc/wzdA7/wVXC4hu1Wbs/HUDUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrEYySNs; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrEYySNs"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso7114639a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791997661; cv=none;
        d=google.com; s=arc-20260327;
        b=W2ROs9ERlzRDNYVhWQzpKj444r1efzER/cgx1Le1a7LiRPhr0Joc55XRed5pmOCQZ6
         7HltdRD5a0HJqSXh1P8vdODUX8GLDV3hn0G7JHbOBwSAGUspQ+5lBAtZ2LX++0dg33us
         1FlmjWpQGCyikWp5HhgN1dlPTy89PzvvxCEvNpCSfLDn9xY2NxZGx3Eog2Mr3t+SY0JX
         o7v1oKb19SZnl+SBMw9RUxaWpOpt4BM629wnxYMCPOwdcXMz7EoRg9tPu6gGwk3DDBTy
         L+cO0PYatrmU2iXkfJbre80YufEGSlh7/JLdQmmnU0UdgfHgGtKpmlP51Llw0str3iLp
         t++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sdFd3r41M7yyc6N2ofKUYBcOXWgEzV7hB2FeJ/0r1mQ=;
        fh=zT239D3uluY0S4SaxSt6v9qsARJBm0AH8ZIzY6AOLC8=;
        b=g1UB+AM4+rXpXNExAl/xkaJphcUoq1hkR780/vXR5jUJrnbHVbvcZ2YW7IMzG6vrfT
         jVQ1OOm3rntmhhP+cpgi0rGbyMmPavakwFZAV24TpVvjrmFNQm4QKvq/z0MleEM7lS9q
         Jg+R9QEvkZcVTtY/0SC4n0fzKEwu6soxlqbdkmF1OFk9IGAMRU7JURE4qoa/Zd33jVMi
         bNGlf2AfhStjtFYlqcXnFzjv/ouXPyKXC2P39uxlPHiZPgQ1N18nw7Vpcu/9rpiobhdK
         PbAtnpy+MhloJeUI0xEoufkPmvpsQffxl1+qOps9BVKR4WEykAr/T75Zy8jCIHbkzfH8
         rAXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997661; x=1792602461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdFd3r41M7yyc6N2ofKUYBcOXWgEzV7hB2FeJ/0r1mQ=;
        b=mrEYySNsWseLC2l+53rWTlhw76X+YIL5ycc5vq0799t+s6A2x9vDqXVd9VqDf1FEy/
         pnZpRIrts8tgLvUaCfJWhkn6oEE8u8+3Eoe8PdFt8BP0/VHtDLTW8reB4uMoRt4DkzbD
         rUqP2G6xntA4N08A6CagNg+W73HGGEC0SpREw1oVo+SlI1q6TTPvR60ntSLIUK+d3NHg
         pDfzIlC3Au4QYu7R04VGC/FH0ajG4Qqw5xPzJ5SXsxlclq6JB93IxHHdBqqpNi3DUaVk
         3uyFZtd+DS/dKtimIlCO4gbQv0+rjL7Y0ykxr965BDomvtPVW/LMa//WnN8dM+Jq4l65
         2PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997661; x=1792602461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdFd3r41M7yyc6N2ofKUYBcOXWgEzV7hB2FeJ/0r1mQ=;
        b=O4dU/de6hsRzLcY8pEqi0oUirq6abOx3YvQAi8BKg728CyIs0tL8O5EWrA1mIUr0hk
         hY0bU/+Qac1oQiwhXslOX2xfUBo++VGjidV7KtvqZhscIZkDgFjjFShrrFa6LJEjuwjH
         Og9S/M9coRtbR7JOtXP82e9O5AjjUfnL2ovhzTLaBtNcb8MdnKRT4MvoNKaQkc7qFDhG
         EgCdmO//569k8TpUNmdEgiaiBwgNSMK5yjYkDcFwP9fn+FHnU6kytUYPK8S2eL58tFH6
         5XyR0Cvpo7Mo3NcTzz2ClBsOk1QnfNFaU1Pha2vs1pynzRXHrsgdqNhEzPlsON7ln6tg
         qTEA==
X-Gm-Message-State: AFq9FYLKb+hhaD1hP0No+jlWMV+FESoBVSJmKMe1kuz4S4yvFMJlslV2
	cc0AbWpM0OnwLG3EV1Tgf5AUGxIgDVTnWfBuEz2WRCnBJmpQ/awv7+0FKzF6tsNEBmUqQgToJeL
	zFLao9qwNehYS6XwizwoHx94iGHpw9SU=
X-Gm-Gg: AYBFou1wg2bHblIBlFWqYKCjwO2LE2k4rwkGYKRiED+akC+k2O9E0Kw6/TrP4TLqtNO
	94wNd9/1phRsPcwLT/iNClThxQLawDE2rllcDiiLYTsjVevtz2B1UnT//bPWSadxmOymj5DfGXl
	RWo5UrzK9xUqyU7uLaHJU8jUGb6ocH6gM/mn/BD7W5no2lkgZDKdIyG10Pslc1jXSA9duBEnQUk
	Z9vv8vDHDccnjLvWXYzmXB++TStRixhrALfIctsROqkcs4wRsyKm2P4HUl5COHEE+2Rt0qr2Gxd
	vyTuF+pJTC2n+vbo8YueLlzj3khU9zIlBODJtj+xbSJe78Ds0S27Q4VxnOrjQ/obN3ZiE9uLRXX
	IzCNVbpS4Wo9UBoWh7k9wzLSllexA73LBSAFOvXOJEHQX1DDaG19hWmu2uJJvqinUtaLIcJFlT5
	7dxPtHGSnm9G4/OaR/zYnkW0uleLaWb2z+7qulSPH2VWh9
X-Received: by 2002:aa7:cf16:0:b0:6a9:9a0e:e05f with SMTP id
 4fb4d7f45d1cf-6b17ae26000mr9090745a12.2.1791997661286; Wed, 14 Oct 2026
 10:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
 <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch> <CADvTj4qgcXE6azsNx-Wg5afatezLeuctGR607qO1WhZSmuqzBg@mail.gmail.com>
 <7ffb9b38-75e1-42e2-86e2-21a1666fc51f@lunn.ch>
In-Reply-To: <7ffb9b38-75e1-42e2-86e2-21a1666fc51f@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 11:07:27 -0600
X-Gm-Features: AclHuK8jlqpg-qIbwAqpxCbEEkIemf37SHQz8CwDLoD9nKTqJNXJIwBV8qcy8Jo
Message-ID: <CADvTj4pVtoMh=H=nJJaPxYf-ZqU8xJEJLMANUAXTFJWb5zBe-g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 10:02=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Oct 13, 2026 at 01:46:24PM -0600, James Hilliard wrote:
> > On Mon, Oct 12, 2026 at 7:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Mon, Oct 05, 2026 at 01:09:05PM -0600, James Hilliard wrote:
> > > > After a failed MAC resume, a driver must be able to stop phylink wi=
thout
> > > > resuming it and reconfiguring the failed MAC. This is needed when r=
ecovery
> > > > leaves the interface administratively up but detached until a subse=
quent
> > > > down/up: ndo_stop() must finish the suspended phylink lifetime even=
 though
> > > > the MAC could not be restored. The missing transition was identifie=
d by
> > > > code inspection of the stmmac recovery paths.
> > >
> > > I don't particularly like this. It feels like a workaround for a
> > > broken MAC. It would be better to fix the MAC so that resume does not
> > > fail.
> >
> > Fixing an identified cause of resume failure belongs in the MAC
> > driver. The intended purpose here is narrower: allow orderly shutdown
> > after the driver has returned an error, rather than recover the MAC
> > through phylink.
> >
> > stmmac_resume() already returns before phylink_resume() when hardware
> > setup fails.
>
> But why did the hardware setup fail?

The exercised failure was injected, rather than a diagnosed spontaneous
MAC fault. This change comes from auditing the existing error paths for
the deferred stmmac recovery fix.

> This is what i mean about it being a workaround.

The deferred fix addresses a separate software failure: suspend has
already disabled NAPI, but an unsuccessful resume leaves the interface
administratively up. Closing it can then disable NAPI again and hang.
The recovery changes preserve resource ownership so administrative down
can finish and a later open can retry initialization.

That shutdown also has to finish the suspended phylink lifetime.
Without MAC WoL, suspend has already stopped phylink, although
prepare_resume() may have powered the PHY back up. With MAC WoL,
link-down was deferred and the MAC_WOL disable bit remains set.
Suspend-owned advertisement changes also need restoring.

Those are phylink-owned states. Avoiding the second NAPI disable in
stmmac does not resolve them, and calling phylink_resume() just to
permit shutdown would reconfigure the MAC after its setup failed.

The required operation is therefore to terminate the suspended
instance without bringing it back into service. Cleanup must not
depend on first succeeding at the initialization that failed.

The original resume error remains an error, and an identified
MAC/PHY sequencing defect still needs its own fix. This transition
addresses the subsequent shutdown failure; it does not hide or
work around the cause of the unsuccessful resume.

>     Andrew
>
