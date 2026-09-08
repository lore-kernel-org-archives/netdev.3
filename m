Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7557F732
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886941; cv=pass; b=Psr06uvgh8qhnqiU2ILxbReeB4I7QO91VgzYkl+lKuh+ya/DIJFc2TgK12tj2K9wUBaHtvDzWsRcZVtTAd8cPz8b9VW9KV9wROpJuV+rTnBDRsLkKZQSfVGs9S4jj2uvs77FfEXnBebefBAkULHyB6Eo2Pf3bGrlPsMjaTUw/cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886941; c=relaxed/simple;
	bh=X/vlmIamoVJ1N4oEbLCrVWZEehuRo5RS/itbJdU6SyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG6u/DL0EAKRfwbN/I3xbNZ89fYEE09ur1cjfBjdP5Zc3S+/fWcq/7UhdreDposJooDSz1xcB//w1ifJtwYk8dkwPu0bFHjIIf5lfR06nE8JAOI2ekjjrEIKb25GZs648a6BDbYvIFILOoj2Y1P4M81H/1IH0SUZVMyX1C2Ibjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzvYBH6X; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzvYBH6X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so27216315e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886937; cv=none;
        d=google.com; s=arc-20260327;
        b=I52UlQlDcmS6QInQnYfDO+FPVnV6YQMWOZ3Af3tDprOT4uU17wG5DeuWBh5PZ7Xf2E
         0hMvxDVI7UWrgy1tpBGsV7VYDvVe13p1EEvkxi83uvYN3fmcWvvqR0oo82KS77gx3n1P
         JK4FPyMwloNqeLQq6g4gBB2r5sr6H3/aJiwxWpyggykMkD5te1IX8RBeld84Yq5vcdVk
         eKdlYJru0d8tzx4OlBJwp2z+tZXiW7pJwWYQX93aFTcDKcBNlzNc6M5XDdddMc5NIqFl
         vw/dzePFvVBOB66glunp6Q6m74rpSaVkRd/Pyautt7BMzTvA8AmuUlHnHdg4xJtmlo2D
         8TAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X/vlmIamoVJ1N4oEbLCrVWZEehuRo5RS/itbJdU6SyQ=;
        fh=Vr+vmpmXXI83W17WC2heTi8xnrM5l2+ykroTdedc6VM=;
        b=pKLc2nCmWf61oCfO4N7datnZ5kgtQ7vCyy2NVtQ6TCM4VE/Pf1gO4uksm/Z6n09slb
         KLko9B53nNBy5eb+SCSra52mSwvK89AhDtkGCRuDWlLoJJx38rL1ClmXYwvVYlVVBM5m
         WTKVSD7jubcSrY1u8+WN4ebzRph/2vAjAKWdAhX5JT0QMEmI9/wU3PhGrhMDJZLw8y0K
         c6tEaONfO0wq4CcKoelQOJ7eWctIUgVn2+/4Fz233G2OrKsuRE8ysiMhVruNLyzTYJXI
         4T6BBDVtpwtjaTnzwHlAfJ3ALWHaP/SFSKCk6MekQ63QJvvr8hr4XUyJ4iq3LvXKBSPu
         Hw7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886937; x=1789491737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/vlmIamoVJ1N4oEbLCrVWZEehuRo5RS/itbJdU6SyQ=;
        b=VzvYBH6XlnBVomO05VVET5NV91hTbgU4ElSjhf201MSbKs3d3Ym6QLDsZoO1UUvyKm
         Hzch1hLBgExSIr4J0f0KYj3Pkm2w4hueK/9G/cWkXuaZJcsqU0UJ3icTDWIDe7BjuKT7
         fsPUoH74wu8uRR/T01Is4InqKjx0ybadKPETnTLaGPdENgqb+lDI1Vj9p3j3dsfCjvHE
         WXWF9bFDuBotBOjpnQTaAIPh2Tw7s/qWPFW0iMs88W+hPktkEReK+gXwfh8f0Or57BXr
         5kHyTXpZJYitlAAybxh+fAFVkMVlK2K6P29gNZ+ztBXIgfTrFmqX9cmzNGPjTJJKUPxZ
         QsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886937; x=1789491737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/vlmIamoVJ1N4oEbLCrVWZEehuRo5RS/itbJdU6SyQ=;
        b=OFUmy9Ncj+zDkRyBd1vRR/1DKfcmb01dfrGBeKKhrY0npPYyPmSb9ehj58PWcnEeE6
         ekVXYl/X3VlKvgaRWxfuxgsWB9zN3vj8amgFi/DMumysve9xu28oEtkDddSZBYHOpADC
         SYohJaaAcgYne+bWtS3/PevPzcjyAUdoHwGdA+kEltZcGZpVPjqHoCvRYigvpe+QtwXS
         2+wWOXaKqqAvsMZcM67qRzcVru7l2XGfB5VpipX77zKlgPD3TAUSnlv0uW6c+kKcDsff
         i5FabI2kf1W1LLXOLU2r0jHhB3Fe/Q3XqgPj0DeN86iKpjw3BxphYW15d4h0WLAM8gyo
         k18Q==
X-Gm-Message-State: AFuF++kMdORJtLtEd5Yw2HuNlQRp0XBJLloGbxJY6efIkK+yXyvqGj1L
	YnY8ykXP/mDZXyqZoEt6aT3ZVXl1YubVhpC6vtbwiXLnvZHTPKrL6oXNy1du9xG4Ugb3GmEjlBE
	m1cAL3tSoP3eta1HSinGN10hcg8hmIJM=
X-Gm-Gg: AYBFou32YG3BaEw2KUZWUX8A9jvEmSCuFXx5MKV+XdV8RDW5Y/8kFnlHOViIW23DLUL
	THOHYR5440TPouYdlvFxlw7pgugt3yu+6sQ5BOtgptZlbb75RYA+5dHxT2G9rnIrotQxzIWCmyX
	G8Ndt3jYKP86CqMIauEsWhsgA97mjiSM9f3HTbMSc+1aKf0YGd+t85x/4bKKBShP841m6foBhBV
	jwaHe1aGVquxyqVW/uqXllGRYPmPTEPnC07VylOEVZbryRHF0m57EhuCaDX+HHHFXqJoHsHOgJJ
	HJ0jV7kFvx6IIlubUlRoQvwnaQUG25Mn6BdonvTEK/r5JtmYy3fHQZ7yl6CJFseKUkn1zhH62AO
	xTWlNgG/8ZFU8uSkESFGPJ+hl7CKZm/mgSyz3vfmqnmriLziN5lDmWWdUQCFVBRU=
X-Received: by 2002:a05:600c:4e87:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-49d1df815bdmr30523255e9.18.1788886937314; Tue, 08 Sep 2026
 10:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
 <97beb3b1-95ce-4cfe-83b3-cbef9cd514cc@redhat.com>
In-Reply-To: <97beb3b1-95ce-4cfe-83b3-cbef9cd514cc@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 8 Sep 2026 10:01:40 -0700
X-Gm-Features: AcwNN1XDmypP4TIvQ28ZEWCnPBSEHnT2yRONzY6JN2nrZhd8RLINHOc5HPUzQW4
Message-ID: <CAKgT0UddZ6DMm2aiXQ=h4KrF3-WHeBG0iM-E5-TMKHu_LPUXtA@mail.gmail.com>
Subject: Re: [net PATCH 0/4] eth: fbnic: a collection of fixes
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 2:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 9/3/26 12:31 AM, Alexander Duyck wrote:
> > This series collects a handful of independent fbnic fixes for issues on
> > released kernels, plus one core ethtool fix needed by the fbnic offline
> > self test.
> >
> > The first patch fixes a NULL pointer dereference on unbind after a fail=
ed
> > PCIe error recovery: fbnic_pm_suspend() frees the napi vectors via a
> > direct ndo_stop() while leaving netif_running() true, and when slot_res=
et
> > -> resume fails the data path is never re-allocated. To prevent the pan=
ic
> > we reset num_napi to 0 before we free the IRQs which prevents walking t=
he
> > unallocated napi vectors when we unbind the interface later.
> >
> > The next two patches address the FW mailbox. One sets AW_FLUSH_MODE
> > alongside AW_FLUSH when tearing down the Rx ring, so the write pipeline
> > actually drains the staged requests instead of hanging on the BME halt.
> > The other handles completions flagged with FW_ERR on both mailboxes,
> > which the driver previously ignored. This resulted in us parsing a stal=
e Rx
> > page, and spinning the capabilities poll to a timeout on a healthy ring=
.
> >
> > The last patch keeps rtnl_lock held on the ethtool ioctl path for the
> > self test. Since the ioctl path became rtnl-optional for ops-locked
> > drivers, fbnic's offline self test (which brings the interface down and
> > up via netif_close()/netif_open()) runs holding only the instance lock,
> > tripping a lockdep splat / ASSERT_RTNL and reconfiguring the device
> > without the lock it requires. An opt-in flag restores rtnl_lock for
> > drivers that need it.
> I think some of the comments from sashiko (the high ones on patch 2 and
> 3) should be addressed in the same series.
>
> Alex, please note that the current expectation is for the submitter to
> treat sashiko comments alike to human reviewer's one, see commit
> c82ff94592fb68f529afe63ca7f5ddb7dae4ba83.

Thanks. I will go through and address the comments. I assume that in
the cases where the AI is recommending something due to lacking
context I just need to add a comment or update the patch description
to provide the needed context?

Case in point being the AW_FLUSH_MODE and it asking about how we are
verifying the flush has occurred since it doesn't seem to grok that in
the same write that set it we cleared the BME so the device itself
cannot issue any more writes and the read completion essentially
clears the PCIe pipe.
