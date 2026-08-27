Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001133E0088
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874197; cv=pass; b=Bo41fYl8poP2PTW/t5gddp4u5cMRVJ2FufLDxDxraDITi4zVgWriuowhL4ERaS+4LsKKwv2aqSMUoFvzAxcR37xCGvK7A4zPJ7rjB+1b88i0N+3Fxh2G7zfHBYQYpZEn1KDvVdhQIqwcQO9EFnIzIWBKVMDTcZeE22bOcQJxPDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874197; c=relaxed/simple;
	bh=cSKSfx/59yRAtBN6rzZe+Wqszk/rPDpop3KwAEUEv8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyWwQw0bzdv5lwm136s/AxnR5yPvZzeDOEW0ChhZzFbMZ/3XFJaytFAtv2KwOpzDgmjWJi4Ns4FUx5Irwy+V+5wdqtwAIbHLB6KeFMwhhi8b3eO/gKpljbpu8eoyF1i0Vzqt61hIOBz63WmeTpViZDotfABTOS5WSXyXDfDc4T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaJkvaHL; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaJkvaHL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso25365ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787874195; cv=none;
        d=google.com; s=arc-20260327;
        b=fL8hoOA71IXadlwEg3Mpmcf+9kEozvbJ4uplA/Iw/zLOmR8O6EnyFui5Ugc/e8Ahr5
         Xcg/xauB/66SkDDs+IlI32ut264QKDUPA+eK5ihFYbhviHh1EzFMyR64QEI38IiKGVJ5
         4aHHHJNFoijN2ImU2P0y1FUkqerWsjFjouzD3syesQD9fmwxjU/6ci66+g6pZgey8THq
         Ix90btDW3gHm9yxToBY7LJhPbCFW/JJYBBjYXGaMZrnmLKVP/Zvbk/p4imzUx8xUzPvj
         jpMbJXl5V9YbD9e6OHtPlf5Kj9tmwEMUr5/lzc2M0QMmUOCTADfpmQgl2MkZ33qgQ/tS
         jl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O++z2aE6yFoicVs3sp+z7gXtDg6P0UZKy68Ki4lge6A=;
        fh=8pnouobuNmySElQPaCJPRun3CukBWhFlk+rHOuBxGvM=;
        b=ry6qxVfs2f4YWZ1y5pMa/bPRaicH/z2nK9dHGpTwHqx2UAXtEfzs/8kVq+01EAp9et
         AIX1gqRaow2PbcKhcuVkc1xWNVn/DxseiSdjq2B7uAtTexrVB+GkcxJUWApNAneJliPO
         94TQ86UP7HTxdJ/49HO7mOGbx/9wbYrOT91VCPwRHrJ6KGrzzHMefQa86Wp+LWEJS4X/
         6uEDK5sb2+u8UeQVwKUgnMhI12fMKj3ZK98EI865icKDrLZoxh1U9gmOxVaAVnid82XV
         J/6setVJjaFwoy+N8DMAlYO6SPyemnhupci5Ulse7CyWWui2Grw9fN03hXqKns/vpkbS
         Nlnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787874195; x=1788478995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O++z2aE6yFoicVs3sp+z7gXtDg6P0UZKy68Ki4lge6A=;
        b=kaJkvaHLXH7Qrim7poPjDiyCSkRQVqZCIssjH7swbs6xC9sL8X+eK/noF+vcUx1VeJ
         wdKxBXETgOteYavAcMQr5Nwd+7j+8JQRYYV18iwYSVyx4eJXx2rU1GUyCiRtPzXreYmQ
         GdjhMhT+CTbV1SoYfdME1JpS1gcV0tR3ZrcwvScHqB9yZIJ0el9L7o/62+EV02yCBchS
         /f2d97TapeKvj91OJnZxJYtnKQT5iTEUIvuaeO4vbxuLxOBx5djxWIHfwwTq/oLZDbTM
         efMoNhBE2DN3Cysg6Icp7qGyLtu+l2N2YM8fEfDy/nZm6GyJsOrvsVOd8SCz1vuq2ax5
         +u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874195; x=1788478995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O++z2aE6yFoicVs3sp+z7gXtDg6P0UZKy68Ki4lge6A=;
        b=TQROmw45l/8P1eFgTuCHN54uyz8RKxJBgEg38Q1iD3c7yF5UjZyk3Ml3kiOfD3CNvL
         rOhqJB7LVPa1F/A1i4rGS1E2kBU4WJUVDtyfxiX0vrciy4EmowsQ0QZ8z1qG1znTIQXC
         jUWGyMaEVy2LSibrek+2ReFQUBt+CQrl2r2pMQ+xOWs69mftknX47CLsB6mYOgFdfGk1
         KDVGIWdiYyqMfqFQuu2qMiJfp401jFMojS48KKqfcOiezK4HKWFkYWrcwTRpw+u0wOdG
         2A5AkWUb3BDYPUmK1o5Ua3dBdv56Iskwe9I1Hc1Ie1xlTWJi/67Nm7C8kUUDjqELPt1W
         /G4g==
X-Gm-Message-State: AFuF++lFBoRU52SRlU46Ky9WZaKRz3XGbR6jhx3oSJprcT7rFQWZSlC7
	cq1TYE/zMtC2WrwfvlSogCm3aMBdY9U7LFoEskb2O8hEPrASQpXBGOMGJ+lO5/lS7hBOlR4ZKcH
	2d0OzwisksUZy11lWEGGosX53lqgTXoQtJxwhS/+l
X-Gm-Gg: AR+sD128ns7cVIlHYEXZz/Kr8vNZfK+oITLi/lTBjmRQlf88BThm0OSIWDyb3AfvQKc
	EuH9Yo46l5JUqAOLKcxIenkLmvDu8yL9V5RhI7Donoh+1hMH4a49H0b7i3RsSiveUfwSFXuhBm/
	VcK+EuKGKHXFK5VX+bjA+xi7BETEZm40yxFySwnHhg46WaDWtaZR8EwkopbdGfaLy6B8/mVrQ1Z
	iQ8JUVpjVLU8EJMqAipKet6AGCN9JKQ/uYHTTnonbFf+UmvtSmbVooWC1fr766yixeWBXVVndcv
	GYSYMnyCnEcQCm9sB6IOHOWYEhf0eAjW8irSJ5RR+qf6ofbNpmdjRCK/e0ddjlbUmj6u5PgHw/b
	a4WwDlx5DAxeDzG/dEWxrvuWe+KpgXAgc+s5ARm+KlQ==
X-Received: by 2002:a17:902:f709:b0:2c7:f688:f22f with SMTP id
 d9443c01a7336-2d75485ff5emr1770445ad.13.1787874194457; Thu, 27 Aug 2026
 16:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826095243.16939-1-mengyuanlou@net-swift.com>
 <CAEAWyHf4bVm_DQbLo=Q1NwJ2g5WY2HU7Y+ApndDHdAbEDnfk4g@mail.gmail.com> <8875A5CE-3A34-4227-B06B-34E8292D19F5@net-swift.com>
In-Reply-To: <8875A5CE-3A34-4227-B06B-34E8292D19F5@net-swift.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 27 Aug 2026 16:43:01 -0700
X-Gm-Features: AcwNN1XSt7ZJy5BpcFpPjtu3TQoqBEltu0qlr5PU_bh2zzNG9ZmOWsjRMMXO0wg
Message-ID: <CAEAWyHdJ+J6wJP9c108p+K3pKPXg4YzvyPPjxoK5KB5Q+-OjwQ@mail.gmail.com>
Subject: Re: [PATCH net] net: libwx: Fix PM suspend/resume flow for VF drivers
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 2:08=E2=80=AFAM mengyuanlou@net-swift.com
<mengyuanlou@net-swift.com> wrote:
>
>
>
> > 2026=E5=B9=B48=E6=9C=8827=E6=97=A5 08:41=EF=BC=8CHarshitha Ramamurthy <=
hramamurthy@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Aug 26, 2026 at 3:01=E2=80=AFAM Mengyuan Lou <mengyuanlou@net-s=
wift.com> wrote:
> >>
> >> Currently, wxvf_suspend() and wxvf_resume() do not acquire the RTNL
> >> lock during device state transitions, which can lead to race condition=
s
> >> with network interface configuration operations. Furthermore, the VF P=
M
> >> callbacks lack proper hardware re-initialization and error handling,
> >> leading to potential unhandled errors during PM resume and missing
> >> dependency tracking between VF and PF devices.
> >>
> >> Fix these issues with the following changes:
> >>
> >> 1. Hold rtnl_lock() around suspend and resume paths to synchronize net=
dev
> >>   state modifications with RTNL core operations.
> >> 2. In wxvf_suspend(), close the netdevice before disabling PCI device =
and
> >>   clearing interrupt schemes to ensure clean resource teardown.
> >> 3. In wxvf_resume(), check PCI device enablement errors and perform pr=
oper
> >>   error unwinding if interrupt scheme re-initialization or interface o=
pen
> >>   fails.
> >> 4. Add device links between VF and its parent PF device in probe() for=
 both
> >>   ngbevf and txgbevf to enforce correct power management ordering.
> >
> > This patch is trying to do a few too many things.
> >
> >>
> >> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
> >
> > The patch adds code to ngbevf/ngbevf_main.c but the Fixes: tag is for
> > a txgbevf commit....
> >
> >> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> >> ---
> >> .../net/ethernet/wangxun/libwx/wx_vf_common.c | 30 ++++++++++++++++++-
> >> .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  5 ++++
> >> .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  5 ++++
> >> 3 files changed, 39 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drive=
rs/net/ethernet/wangxun/libwx/wx_vf_common.c
> >> index 26de78e9a69e..2352cf12b289 100644
> >> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> >> @@ -16,9 +16,13 @@ int wxvf_suspend(struct device *dev_d)
> >>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
> >>        struct wx *wx =3D pci_get_drvdata(pdev);
> >>
> >> +       rtnl_lock();
> >>        netif_device_detach(wx->netdev);
> >> +       if (netif_running(wx->netdev))
> >> +               wxvf_close(wx->netdev);
> >>        wx_clear_interrupt_scheme(wx);
> >>        pci_disable_device(pdev);
> >> +       rtnl_unlock();
> >>
> >>        return 0;
> >> }
> >> @@ -34,12 +38,36 @@ int wxvf_resume(struct device *dev_d)
> >> {
> >>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
> >>        struct wx *wx =3D pci_get_drvdata(pdev);
> >> +       int err;
> >> +
> >> +       err =3D pci_enable_device_mem(pdev);
> >> +       if (err) {
> >> +               dev_err(&pdev->dev, "Cannot enable PCI device from sus=
pend\n");
> >> +               return err;
> >> +       }
> >>
> >>        pci_set_master(pdev);
> >> -       wx_init_interrupt_scheme(wx);
> >> +       rtnl_lock();
> >> +
> >> +       err =3D wx_init_interrupt_scheme(wx);
> >> +       if (err)
> >> +               goto err_pci;
> >> +
> >> +       if (netif_running(wx->netdev)) {
> >> +               err =3D wxvf_open(wx->netdev);
> >
> > Don't you need to reset the VF before attempting the open?
>
> It is not necessary.
>
> >
> >> +               if (err)
> >> +                       goto err_clear_int;
> >> +       }
> >>        netif_device_attach(wx->netdev);
> >> +       rtnl_unlock();
> >>
> >>        return 0;
> >> +err_clear_int:
> >> +       wx_clear_interrupt_scheme(wx);
> >> +err_pci:
> >> +       rtnl_unlock();
> >> +       pci_disable_device(pdev);
> >> +       return err;
> >> }
> >> EXPORT_SYMBOL(wxvf_resume);
> >>
> >> diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drive=
rs/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> >> index d79cf8d8484f..69bbfd95597c 100644
> >> --- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> >> +++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
> >> @@ -171,6 +171,11 @@ static int ngbevf_probe(struct pci_dev *pdev,
> >>                goto err_pci_release_regions;
> >>        }
> >>
> >> +       if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
> >
> > Accessing pdev->physfn here from a VF will cause a kernel panic inside
> > VMs. Also creating device links to the PF is odd. The PF should manage
> > its own PM state.
>
> Yeah, you are right.
>
> But my problem is that when both PF and VFs all in host, VFs resume befor=
e than PF.
> VFs can not work if PF is not up.

Then, you can punt the VF init on resume to a workqueue so that the VF
polls and waits until the PF is back up. iavf is a good example.

>
> Are there any good methods? Solve this problem by itself in the pf resume=
.
>
>
> [24500.725614] smpboot: Booting Node 0 Processor 23 APIC 0x1b
> [24500.730077] CPU23 is up
> [24500.733353] ACPI: PM: Waking up from system sleep state S3
> [24500.842648] ngbevf 0000:07:00.0: enabling device (0000 -> 0002)
> [24500.843113] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for VF.
> [24500.843144] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for VF.
> [24500.843185] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for VF.
> [24500.844013] serial 00:00: activated
> [24500.853861] ngbevf 0000:07:00.0: Could not enable Tx Queue 0
> [24500.853909] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for VF.
> [24500.864810] ngbevf 0000:07:00.0: RRCFG.EN on Rx queue 0 not set within=
 the polling period
> [24500.874722] nvme nvme0: 24/0/0 default/read/poll queues
> [24500.904063] ngbe 0000:06:00.1 enp6s0f1: PHY [ngbe-601:00] driver [Gene=
ric FE-GE Realtek PHY] (irq=3DPOLL)
> [24500.904598] ngbe 0000:06:00.1: registered PHC device on enp6s0f1
> [24500.904836] ngbe 0000:06:00.1 enp6s0f1: configuring for phy/rgmii-rxid=
 link mode
> [24500.950076] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver [Gene=
ric FE-GE Realtek PHY] (irq=3DPOLL)
> [24500.950509] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
> [24500.950549] ngbe 0000:06:00.0 enp6s0f0: configuring for phy/rgmii-rxid=
 link mode
> [24500.971368] ngbe 0000:06:00.0: Failed to obtain mailbox lock for PF0
> [24501.000057] r8169 0000:08:00.0 enp8s0: Link is Down
> [24501.053774] OOM killer enabled.
> [24501.053775] Restarting tasks: Starting
> [24501.055611] Restarting tasks: Done
> [24501.055623] efivarfs: resyncing variable state
> [24501.059625] efivarfs: finished resyncing variable state
> [24501.059651] random: crng reseeded on system resumption
> [24501.059656] PM: suspend exit
> [24501.151222] ata2: SATA link down (SStatus 0 SControl 300)
> [24501.151329] ata1: SATA link down (SStatus 0 SControl 300)
> [24504.026452] ngbe 0000:06:00.0: Failed to obtain mailbox lock for PF0
> [24504.026461] ngbe 0000:06:00.0 enp6s0f0: Link is Up - 1Gbps/Full - flow=
 control rx/tx
> [24504.230844] r8169 0000:08:00.0 enp8s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
>
>
>
> >
> >> +                            DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_C=
ONSUMER))
> >> +               dev_warn(&pdev->dev, "Failed to create device link to =
PF %s\n",
> >> +                        pci_name(pdev->physfn));
> >> +
> >>        SET_NETDEV_DEV(netdev, &pdev->dev);
> >>
> >>        wx =3D netdev_priv(netdev);
> >> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/dri=
vers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> >> index 8b16b900820a..3868b70ad152 100644
> >> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> >> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> >> @@ -228,6 +228,11 @@ static int txgbevf_probe(struct pci_dev *pdev,
> >>                goto err_pci_release_regions;
> >>        }
> >>
> >> +       if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
> >> +                            DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_C=
ONSUMER))
> >> +               dev_warn(&pdev->dev, "Failed to create device link to =
PF %s\n",
> >> +                        pci_name(pdev->physfn));
> >> +
> >>        SET_NETDEV_DEV(netdev, &pdev->dev);
> >>
> >>        wx =3D netdev_priv(netdev);
> >> --
> >> 2.30.1
>
>
