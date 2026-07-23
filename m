Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E53C9EE7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786544; cv=pass; b=kbt+xiFUG2E0ljLitFYrcyOCUzccQEOd8r+KYRn5D8nDKWed1R5WhcAPFBcHnYHKvexbh95aqntF6lhiOw7jlTrrgxedp8e6KZorpL8mcVOiROtfBcWFX6Os5Up9wBte//4L4nSrY1RsZKatK+2jgBlEV/oq/r+2HraYPLA46ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786544; c=relaxed/simple;
	bh=kSJIC+r7c/HNToAevJYByYV/xUrFNPPZFO8/z9EyAvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRl0ECB3xje4llI60plcTrZhoiTXJnYvUcayk6hEwceTEwc95PFRZceXhwmBSJMxDiG8EVg4ckoPG16ZYWri5Mfyp9Qll+sExNPKTPC3XnLXaha3hNSqisRq2Zq9wJ1iWrCcv4tt7mG6adnPi1/UQ+AyJi8AZFbcyHofb/BVMfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh1UdZHu; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh1UdZHu"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4896ae35be9so112744b6e.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784786541; cv=none;
        d=google.com; s=arc-20260327;
        b=WJGUkUqxT5hrgwWyYP1JBXlYnTvR6QkW4VLHgwH+0nLdwwi9RWzWFw33cIukiU/0hk
         Qippt54bM83EUt4pEokVw0MGtDjuaF2SWouGU3F4GqpQ29792CzxleEIH2YyNG5gFRT3
         y/mZ9yEqS5e/twi90g61TadaVYR5GHUXD1+oriL7wTfdegHX8sRqTFVn5N4M1xW9/wr1
         T70vTq0A3Y6hBvKF4C7TSmz4xHsXCv/iSTe4Pye+bL5pGnIlHaj55xkWPeshXRO50yQ5
         n6u3drCQf+4IYJgp/sRtJBMrSiifbjyauOyd4W+zSeCTvUFVOd3mHQTZxzxAa0cVVqFV
         QmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufxWwA+zsgVRG3OBUzq1MHpVFzAaHzP7LXBuqA0qU7w=;
        fh=a25y3ebx4F0h5xBUYg9xJfSgblT+kts2pyqGYgISPP0=;
        b=dbGAUaWWexm6isbKVRC+Z7QCqH1dtZsaM/N9HARIMywQfGyl5KBrqPS+tP7G4toIRm
         LllXEb09oiqvgDglN4oVn71ItJnhnw7dnkXUgb8NVjM5n3XOs9YAhnz6nM7baUTjfGev
         /KpTs1C2lxTci0diriAWAb+SZcNzR+B4uIEGYITcMIAalo408ggWQSkoGh4gNh7vm2FK
         DtngODx9U2hyi+4DPBuFIT1D46toyQvNrUx15uYJ++MJn4pc33yFxk9OT3PPVHpMn4qB
         tcR1fodUTlC2sdoyve1YqF4MriXhTXm+Ti9Yrd2C1ScvWPWy7nMzZ9vrJxmbxD1ZvXBD
         nJTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784786541; x=1785391341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufxWwA+zsgVRG3OBUzq1MHpVFzAaHzP7LXBuqA0qU7w=;
        b=gh1UdZHuDXpNFg5DyRGXDOfjLoi7Do9kdRlRceLBzvq4XPpcDLHDARFIjIVlWUoI0z
         x3w3RKRU+HMu37IBMdqOGC9Nqs+2ITaIGjqETVF8PBOy/obkoEiCJ8tmO9D6kC94+Qu2
         miq+Ft6VFv89SLyNFUt2JtRH5w5q0KKvlDBwk9MWrtF4nIJ0zN26+TEs7V6TH1uCvXPq
         g0SSCBami/Ffj5ucWlC0Qn3bnD8TGeH7kEGuBzDxuiYNDlYngY9nUc/CjOB37ztf5Tno
         ll9NOjJ97NiCoZJooh7g7TfVVsDOUOcs7ypgZ505djE1sucEQ9k3q1Rfd6IHebL9LOD6
         CWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786541; x=1785391341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufxWwA+zsgVRG3OBUzq1MHpVFzAaHzP7LXBuqA0qU7w=;
        b=l+xN412bNzHJ5pggmMftkf63XvnnCmhSbC+rqt07HBa+66mvYhlJmvErVfGOELL5vd
         XkUA6onr718deuCHz6XUk2qXFmI8NWoWrmeRSaZf+EHXj4WAzh0qn7SgSxFoXnwAypis
         3YguW4QiRRMB8vcXrKC8X/Oa+pNd6i/3Uqo0VikwHz6m193vFh9gXwL2a+SSUZ8FrExP
         Cf/OJPCjAl20aoc+07UL+NvtUiHOrEwaxljvlrShjF39lHpOtFwwtDqRamjdzgcEy9lB
         8hZJb7uUtUCbJzfIJk1K1MAXn3zyzuxUDepPcx27ctmk2+8n5YzkFPraj+7VDdpTSBGO
         nYfg==
X-Gm-Message-State: AOJu0YzStJgSvos1K24v336LCqYfu2FNcVU1vwS6O2qS5KIPrZeTC9hH
	wiFIcxa+0V9fmGm8Ka1m/YWAldVeBtpE2RkEw7AemGNRChoHkl237pJiL4RrLzCbIPFTKTfBP7u
	r71cZO+dhCsVzelObLPge9YqXbFCAzlo=
X-Gm-Gg: AR+sD12v801nU7hELqbzQqZYPAUtRgyKpxvh7cGT9ru2npJYx21kAmvwJVfi7ixILTT
	WlqRSWC1WDX7yRoOZC/+FD8UfNdeKiIo6XhgyJZIWi4XNZ2oY/vvsaAgbAR/ITKhDyykvvuib3m
	AJiuDztO0bEsw51ImBqWyZuQvjMWMTJvgk0aFk0lMIQPR81+omYM915+bsjfFWuhDLt5rQnYeK1
	Pcd5dC+c4u9Uixx0DbvS9iRYfE5OWhgAPu9620oq0SSZNfGyDxx77I9XFqvCE0=
X-Received: by 2002:a05:6808:1494:b0:498:37a8:cb69 with SMTP id
 5614622812f47-4ab354ded18mr908582b6e.29.1784786541359; Wed, 22 Jul 2026
 23:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722113919.7723-1-shlomojune6@gmail.com>
In-Reply-To: <20260722113919.7723-1-shlomojune6@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 23 Jul 2026 15:02:10 +0900
X-Gm-Features: AUfX_mx748SPJxDfKeHVwWagkaXlY_LdBHwNk_SRopeExJ0Qco4E3ZNap_FvX_I
Message-ID: <CAMArcTUp5caJjwzFye_iS6kD+34-eszN803wGkhWkueRYZOyOA@mail.gmail.com>
Subject: Re: [PATCH REPOST net] amt: fix use-after-free in AMT delayed works
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 8:39=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.com=
> wrote:
>

Hi Shihuang Liu,
Thanks a lot for your work!

> When an AMT device is removed, pending delayed works can still access
> the freed amt_dev structure, which may result in kernel crashes or
> memory corruption.
>
> amt_dev_stop() cancels req_wq and discovery_wq with
> cancel_delayed_work_sync(), but these works can be scheduled again
> from event_wq after the cancellation. This allows delayed works to
> access the freed amt_dev structure after the netdev has been released.
>
> The following is a simple race scenario:
>
> CPU0                         CPU1
>
> amt_dev_stop()
> cancel_delayed_work_sync()
>                              amt_event_work()
>                              mod_delayed_work(req_wq)
> free netdev
>                              req_wq accesses freed amt_dev
>
> Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
> discovery_wq from being queued again and wait for running work items
> to complete.
>
> The delayed works are disabled after initialization in
> amt_newlink() and enabled only when the device is successfully opened.
> This keeps the delayed work lifecycle synchronized with the lifetime
> of the AMT device.
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

Thanks a lot!
Taehee Yoo

> ---
> Repost:
>   - Explicitly target the net tree.
>   - Add Reviewed-by from Simon Horman.
>
> Previous submission:
>   https://lore.kernel.org/netdev/20260714072705.129262-1-shlomojune6@gmai=
l.com/
>
>  drivers/net/amt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 951dd10e192b..7eb871b9b7e1 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -2995,9 +2995,15 @@ static int amt_dev_open(struct net_device *dev)
>         amt->event_idx =3D 0;
>         amt->nr_events =3D 0;
>
> +       enable_delayed_work(&amt->discovery_wq);
> +       enable_delayed_work(&amt->req_wq);
> +
>         err =3D amt_socket_create(amt);
> -       if (err)
> +       if (err) {
> +               disable_delayed_work(&amt->req_wq);
> +               disable_delayed_work(&amt->discovery_wq);
>                 return err;
> +       }
>
>         amt->req_cnt =3D 0;
>         amt->remote_ip =3D 0;
> @@ -3023,8 +3029,8 @@ static int amt_dev_stop(struct net_device *dev)
>         struct sock *sk;
>         int i;
>
> -       cancel_delayed_work_sync(&amt->req_wq);
> -       cancel_delayed_work_sync(&amt->discovery_wq);
> +       disable_delayed_work_sync(&amt->req_wq);
> +       disable_delayed_work_sync(&amt->discovery_wq);
>         cancel_delayed_work_sync(&amt->secret_wq);
>
>         /* shutdown */
> @@ -3278,6 +3284,8 @@ static int amt_newlink(struct net_device *dev,
>         INIT_DELAYED_WORK(&amt->req_wq, amt_req_work);
>         INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
>         INIT_WORK(&amt->event_wq, amt_event_work);
> +       disable_delayed_work(&amt->req_wq);
> +       disable_delayed_work(&amt->discovery_wq);
>         INIT_LIST_HEAD(&amt->tunnel_list);
>         return 0;
>  err:
>
> base-commit: ba712ecfd942b68b21a4b0a5daaf72f6616cc66d
> --
> 2.43.0
