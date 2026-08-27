Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B536655C
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787791300; cv=pass; b=eo191wYWWLixG9KU4y3j65inx0x9Mfbc/348go+m0DBcVjGwB3GNrtdfoBAHRo0RSjHukPOm4cHqfBt/BE/GkNt3KVCNOOQOM1UpgVOq+f1I46O6QTshJhgVCfcN/OOG+ctE45fsQxSOWO1i+5Jd8HWn/H3WrcTTGhbsnIfxA5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787791300; c=relaxed/simple;
	bh=6ApmIcWEg7UHkXT92lpE26+cdHzHWxNILZwhxdkEeqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFIcjhCnUpotu2PssrjqrIpsGqoORDtX4/W9W9vEsBqCaZGFbMqyXc2d4kKA1rzNO4Ot4u+IXvnbLjeUDHy5+vCzJTLBwtsai11oAwd4MCnW+lfsGJcvx1MS3nsDcbMumL/vPokQ1AaX6/WSpmwl6GT56xySAjNG1EaHjCs71I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khEwakb6; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khEwakb6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso48775ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787791289; cv=none;
        d=google.com; s=arc-20260327;
        b=r3mWUtId3SQw3uJH+8F+HN7k33QQzgLni0VRY3wlG2PniGpsVUkw6ecKhQ36pjZizm
         I9cYz1jp6x1XQMjqL+U7BuJYmGpl4WE5v/T5GYWFmc/TCbKwCZ/7K6XUoJNTqLsWoK0B
         jvNA9jxTz7oxDEOH+RL7fqKw9u4BdNSQJYc7h+DeTuVuZ6CuFsvj0cAExnIbXa/qlWXN
         d68a1j8v1LnB5QHumYzCIVaW/FKP5KEUNqYgKm5kHlCLWoUJwZZftLt1SXU/tMtJONWa
         NZ9Nu6v7nWV007U29ynd8Y2xbrwa2LjXO9I2EBs4IWuwbolDKjNio45LEoOiQKuCwarS
         EP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AqICIZ+Jedu5bRc6TU0Ryhv/ZqFIL9x7Z3rNom0xQX4=;
        fh=uCv7BW6T3OkVcWpTwYA1w3kdXkNgqtcr5DAJbfxzkJM=;
        b=EaWZvSRd+uCKrxpoMJ9Db1Uw3grm7htgI6TnxhlJ7IEsK6oKJ42nR1Ot54kwE5pIrR
         a5PxhlrpPvO9hY/BCJYmQG3RCi8fmZC4he3YBynlixAYvxv8doq//l1oN6y+CkQ6qFda
         OEN5+DkmDL0uEyfssqk1qFsiSy3GZ9ko+NGHPB514WRBlD4DCtV+JXKpf4N2UdbnwfFD
         Lkh/gsIFLyhNpVS1rv6Z9nJnimnsm2ZBHmYVjuKoC2QJoZXukcf/TzvjoUOa6MfOCi9H
         5Ozkai/C0w34KdPBJkemREqaQq4puD+6E8RdZ+1Gnci0kY+w+ZWkWWGVypmtKnaH0csj
         S0Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787791289; x=1788396089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AqICIZ+Jedu5bRc6TU0Ryhv/ZqFIL9x7Z3rNom0xQX4=;
        b=khEwakb6xXWPUpdBsNur+CSIijabeZKmbrsQa9b0Cu8utHQl853uW2gZFcxAAmQ3G2
         K5d+3NoaaxydVOR+rA5lr1AISylEvfluHyZwOa0sY91X6jV5mHuiBfanB0jLzQATXkpu
         LooAVMKuP46HCAKpvUtrACkNPolw2dt2GvtkzXV3XtsrjboRr5Ge8pyuCkFZi1tdUL1Q
         zggQTq5M7OOWXa1cpPOZtITLhzClRihFL4dSksKowDr7sMw/mFB5pW4JAedj5JLOxweo
         WSy85hIvh50nZGSBwGZepYxIUrr9RidEhnpXUO+srlnuZjTc8zlJpPyzjYnieA6IMXJd
         lMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787791289; x=1788396089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqICIZ+Jedu5bRc6TU0Ryhv/ZqFIL9x7Z3rNom0xQX4=;
        b=nCbVW6xyI7wrwHNxslr3t2PrR2LhZ5JgoxlvJrf320/zW/pTDWfOcA4vUrE5q2+rSh
         NVtG63890iyX61XtpNHQ60yFexYGCgNRgt20FYq4+996PxkRrvpmZ2tNhO00MZkjfrwG
         Xoog0lwkO5zZnqQIwiMAtJ9KZrIzI6RzlxJGgvTbmtED+SBlFlyn0KaJdBI10RLMbrkT
         mpvmwsSCXJFqnB/p2WhFoPd9hoZELM7wKvJbPITVEEYtXDySrRs7kiHSHrC0MsS3k5Ch
         XvlMfca0ugbhCzkg64hiJQhvkUO3LWzhHs0pRTTJvw4hCC/gGaFS/w8MpoTAre+bAqak
         azeQ==
X-Gm-Message-State: AFuF++nv9sCorWEkXgzkUw4vkjJMXMNDXeP2B+7N3cMBAmpc1aQ4JqXB
	qcG0DMTWefs1aY6tspLWRPEDJn3Smxl2NJPCXj02cFxvYSOe0Kmk1E19MmnjJd9xGxrXKi66KLx
	Xc2bHBpIN4qixirT34xbeJh5/9I02IendoCjLumVM
X-Gm-Gg: AR+sD10dCah85FVG2ZUWyghs8KQcki0pQ3nBXcrSkKAAguhjrxNUu1XyjZc5yL3Ffok
	0Y7l5b+tM7Cq2YBbazKMH9bJ2nat3yASZrBEO248kIxMzzL1rNSobIMSxc6R8RbC4FekBBj8F0o
	xV06dxNYbXL1V7rb/9HKInUPIqddktNxa5Ti6uwlTDbIYgmVckL/arHzQ1O41rzUqrWYSq7rJFi
	9VUIutMiWnuE9kctNWrMQSfrouc9N8hPvG4sA7TQ7vS8mUvmffBW/wlUvgoe5Ixjzcp74ZgTGy0
	Y49XF1AysIqidXFyZYQod9xzKfXdsh3vzQ+yax7kTOJNGr+o/fLfVoRD4PKPCpQv4+AVXR3stF9
	S9BKoLNxvYfejF1m86rc6PgOSTzNX3DDIqr2cTWa4r9E=
X-Received: by 2002:a17:903:2307:b0:2d5:db38:800f with SMTP id
 d9443c01a7336-2d72a78b7eamr3695835ad.14.1787791288737; Wed, 26 Aug 2026
 17:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826095243.16939-1-mengyuanlou@net-swift.com>
In-Reply-To: <20260826095243.16939-1-mengyuanlou@net-swift.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 26 Aug 2026 17:41:17 -0700
X-Gm-Features: AcwNN1V4Fkwf1XZVrLAN9MiICQ8ubagTpmOJ_iZa9fYaUK5azlHnGInjmd9Y40g
Message-ID: <CAEAWyHf4bVm_DQbLo=Q1NwJ2g5WY2HU7Y+ApndDHdAbEDnfk4g@mail.gmail.com>
Subject: Re: [PATCH net] net: libwx: Fix PM suspend/resume flow for VF drivers
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:01=E2=80=AFAM Mengyuan Lou <mengyuanlou@net-swift=
.com> wrote:
>
> Currently, wxvf_suspend() and wxvf_resume() do not acquire the RTNL
> lock during device state transitions, which can lead to race conditions
> with network interface configuration operations. Furthermore, the VF PM
> callbacks lack proper hardware re-initialization and error handling,
> leading to potential unhandled errors during PM resume and missing
> dependency tracking between VF and PF devices.
>
> Fix these issues with the following changes:
>
> 1. Hold rtnl_lock() around suspend and resume paths to synchronize netdev
>    state modifications with RTNL core operations.
> 2. In wxvf_suspend(), close the netdevice before disabling PCI device and
>    clearing interrupt schemes to ensure clean resource teardown.
> 3. In wxvf_resume(), check PCI device enablement errors and perform prope=
r
>    error unwinding if interrupt scheme re-initialization or interface ope=
n
>    fails.
> 4. Add device links between VF and its parent PF device in probe() for bo=
th
>    ngbevf and txgbevf to enforce correct power management ordering.

This patch is trying to do a few too many things.

>
> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")

The patch adds code to ngbevf/ngbevf_main.c but the Fixes: tag is for
a txgbevf commit....

> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_vf_common.c | 30 ++++++++++++++++++-
>  .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  5 ++++
>  .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  5 ++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/=
net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..2352cf12b289 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -16,9 +16,13 @@ int wxvf_suspend(struct device *dev_d)
>         struct pci_dev *pdev =3D to_pci_dev(dev_d);
>         struct wx *wx =3D pci_get_drvdata(pdev);
>
> +       rtnl_lock();
>         netif_device_detach(wx->netdev);
> +       if (netif_running(wx->netdev))
> +               wxvf_close(wx->netdev);
>         wx_clear_interrupt_scheme(wx);
>         pci_disable_device(pdev);
> +       rtnl_unlock();
>
>         return 0;
>  }
> @@ -34,12 +38,36 @@ int wxvf_resume(struct device *dev_d)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev_d);
>         struct wx *wx =3D pci_get_drvdata(pdev);
> +       int err;
> +
> +       err =3D pci_enable_device_mem(pdev);
> +       if (err) {
> +               dev_err(&pdev->dev, "Cannot enable PCI device from suspen=
d\n");
> +               return err;
> +       }
>
>         pci_set_master(pdev);
> -       wx_init_interrupt_scheme(wx);
> +       rtnl_lock();
> +
> +       err =3D wx_init_interrupt_scheme(wx);
> +       if (err)
> +               goto err_pci;
> +
> +       if (netif_running(wx->netdev)) {
> +               err =3D wxvf_open(wx->netdev);

Don't you need to reset the VF before attempting the open?

> +               if (err)
> +                       goto err_clear_int;
> +       }
>         netif_device_attach(wx->netdev);
> +       rtnl_unlock();
>
>         return 0;
> +err_clear_int:
> +       wx_clear_interrupt_scheme(wx);
> +err_pci:
> +       rtnl_unlock();
> +       pci_disable_device(pdev);
> +       return err;
>  }
>  EXPORT_SYMBOL(wxvf_resume);
>
> diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/=
net/ethernet/wangxun/ngbevf/ngbevf_main.c
> index d79cf8d8484f..69bbfd95597c 100644
> --- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> @@ -171,6 +171,11 @@ static int ngbevf_probe(struct pci_dev *pdev,
>                 goto err_pci_release_regions;
>         }
>
> +       if (!device_link_add(&pdev->dev, &pdev->physfn->dev,

Accessing pdev->physfn here from a VF will cause a kernel panic inside
VMs. Also creating device links to the PF is odd. The PF should manage
its own PM state.

> +                            DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONS=
UMER))
> +               dev_warn(&pdev->dev, "Failed to create device link to PF =
%s\n",
> +                        pci_name(pdev->physfn));
> +
>         SET_NETDEV_DEV(netdev, &pdev->dev);
>
>         wx =3D netdev_priv(netdev);
> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/driver=
s/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> index 8b16b900820a..3868b70ad152 100644
> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> @@ -228,6 +228,11 @@ static int txgbevf_probe(struct pci_dev *pdev,
>                 goto err_pci_release_regions;
>         }
>
> +       if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
> +                            DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONS=
UMER))
> +               dev_warn(&pdev->dev, "Failed to create device link to PF =
%s\n",
> +                        pci_name(pdev->physfn));
> +
>         SET_NETDEV_DEV(netdev, &pdev->dev);
>
>         wx =3D netdev_priv(netdev);
> --
> 2.30.1
>
>
