Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A841B142D
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573432; cv=pass; b=ZYRkMZ+C6X2aOXcvYl+SB9gHKrgmgYK+mD6Vw41dpzhmwM8z9VCsp6jSBG2++n3jRzMuraq4x+HeqLQ8Orgq2BCM3eYz6TyHsz2S4+iNlW3L6oCu3JUziBXmCXgwyjoZ2cPPQzsaiRAfjW0EhyJI8NmcUM1VpEmTYsjsx1J8ZFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573432; c=relaxed/simple;
	bh=6Gdeyxax4q6hkH2jAB/kSPMQYAtV4VaAp7NzrdI57Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHJwSFNFLpgLM7dRVVPolVe8HF0aL9C+LOfXpIKFkThh2lEf3y5BbUWo6cch8pWlFzX1pBxjaAwmafrzifhf48xUEB2lcaL8jXnbhr00luq1EsWzakmqsseMAJGkP/G1kBhd3Jrxa99f669wqkpKw4fj5xqHmOp45CIBXj19y9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKWlQdNb; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKWlQdNb"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so19505ad.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 18:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573430; cv=none;
        d=google.com; s=arc-20260327;
        b=YSgS5d4kwNQs+wRgAK+0uNjys0E6twEZqtxUr0R56edT8Lf1llXvV+RDJSb7nhmD8m
         vQhsqxFsBjuK1n4ljsG3LIfg7fGSGKfgLKejL24S8jY1cRc7+C4XqA52rvQ2H7zzodiq
         ISs6YdL5iLorTaf4kD0nuJpa+Cb5WjjiiJSnaQcggSHC250xKljJ4XrGW5KUaAIifCDF
         BEHf5iUlr4NgT4sgWGI0nu7Cn3Tegy7ZmtC6FS0+kwU6DLAb4dNSkqmYpB/x45u5lQAB
         +VgBqn2FMcNg5QXxHBdVNjsJpUe03p5EXarRaHIemaUbZKz/6WmmUk7RY7GGdytcvkNi
         e//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/Vig2RyDuk4aEM3wmFnd5LRtUc9mb7fvqz6FVAeCVk=;
        fh=uCv7BW6T3OkVcWpTwYA1w3kdXkNgqtcr5DAJbfxzkJM=;
        b=Ew/MQ4XT/EssReylj5aOIRQPcAGpOz8AiN+xz3Emz/A7zUa0KgZSCTQgLB2jhh3ShJ
         L2SBVIkPlp91LhQgRMNIn9/x92Vd0as2HBny7s3VxFJUgS2jwDYqdRuUU6VfqbHjRV2R
         fErBgK0aAAf1YLazcqxq/VMFHtCICsetJe2AklcJeLLxEcLShLMZGpqB/1VRImFmUyDO
         tOawPWUoThs/UDt4plaEDXBorcrXhCCccHhlfUe1wTMm4PPxI1gK1xU612P2am4klYN4
         b14fNh1wpv1JgwVl1jyH4LBkeZ45+qANntReRzZoNHfNIgTrmKb8VLt+W7JFBkE3G069
         Ayow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788573430; x=1789178230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v/Vig2RyDuk4aEM3wmFnd5LRtUc9mb7fvqz6FVAeCVk=;
        b=eKWlQdNbEXKiUF4wcGYpcKzoe3UdoBo6uQKn8VBGij46i91GwvoFUW3Qj3gBnw2gXx
         5y6mE64ZKMnSXObYSuNgAJRFQ+I1xGTZ44Q3LtCxDg9fyeYD+x08VE2TWuWY2btVzuFu
         UMmwvc8+4L5XQzGphpps5PyLJ0sxRwQOJEH3tszx0Wtx0HRfDdXI5rUeE1Ljm2h1R8IZ
         +j8qMRYJj5OISGfgMIfMEemsaBZcVsfedME6KaNRHCqphUYmkGmK/DKZ6g3grJaqgr0K
         Z591B7Bacagc2s7u9qHW6qI9836/IhCmgiWmLLA3dPv11YfxGtGGHMzDxbxGjuepmaTJ
         o5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573430; x=1789178230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/Vig2RyDuk4aEM3wmFnd5LRtUc9mb7fvqz6FVAeCVk=;
        b=PGw8R0VG7mKsNoDosB9Udhb+w9xCGz05Gq2D96KeamMknOgQjVe6AlaLEOWlRhii4w
         O/XDicuu3+yaUtNK2ZqKynD0A8/0TXa7R61pJ1G5ObPZO21ciqI9DPopKHlCw6SyCfqg
         NiFsJ5gaIu4QzQfVk7CYe+sqPtmHH9qS+o7UIKKoyLxW73J9i9og9DHiFHUWOfV2X0EA
         XMimCsecL4NaNDYD3kskk80tQRJE4FqS6c+wBDLioRHpYI2Q5xEfn0XrF2SITwnPhCr6
         D9AHJPDhLLkw89sGaoZGUEK3Eqxunf/GojG8nRG4wjpTMJyKAQcn5m8l5R9/MS/S4cjo
         lBRQ==
X-Gm-Message-State: AFuF++mtga5yA3XDBUlFtlKsgHJ7bZHxDY/n/XwrhzK341WzAMZRcQl4
	AqXUXQ5Lj2z3puzhUM1RWZ3KdYHhPjTMHC6teEh+h9QXw6o4ocoLkAqN5Iwdmzq4o+jGTiguHoX
	O1A0z9W6gw7+nRe5gsC+NIsqxRwbTxb4SNknzAuAJ
X-Gm-Gg: AYBFou06QPNvoHd1aBSYrjDmrHpQ+t60e8OgdMtrvncPxV2SrMNHZu0+UDBwiELQD43
	YJc8/ZQSCNr5EU8DQ4pKdN/j0gczfiEYhdRmYilHGyRI6wCjnQgAARQEsOcKWhBCakJKy0swJ/V
	9+AXLLbaEPxi371N/j+VALW+DTBqmUVN9TGy4fOvpExSQsOeQd0zXyKpeSg6xmwZVCGWnLQnD4U
	DGTr7jfymAzIhY2VyxA5bAeG9tI8uneqKK8FAazd9NswPBq2OwHU5zkId8oa3x0dzQrcQ/8Nb8t
	SG+dWRFydv4qhkeOLHFh/mG9Epw5uz73GkUtF5oqaY5bzG5IuztXz+wbYqRlcZ4b7N45FYiQUEO
	ZW64l6F3pQTYFQ8CbSfgOPCghdsBDuy+l2HUD5dMYnBEadYs=
X-Received: by 2002:a17:903:98c:b0:2ca:6bf:5bac with SMTP id
 d9443c01a7336-2db28e87a03mr3224175ad.8.1788573429970; Fri, 04 Sep 2026
 18:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904085216.43469-1-mengyuanlou@net-swift.com>
In-Reply-To: <20260904085216.43469-1-mengyuanlou@net-swift.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 4 Sep 2026 18:56:58 -0700
X-Gm-Features: AcwNN1UPIgSr42zW9HYnKxGr7M9ZqK3aDvX4RJaajyF1P17DTve_Ljwrh6sPUWU
Message-ID: <CAEAWyHfapofRa1qDXORqdO9+G+=U6P4-C5aEMnugYnwgn=6ZuQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: libwx: fix PM suspend/resume flow for VF drivers
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:52=E2=80=AFAM Mengyuan Lou <mengyuanlou@net-swift.=
com> wrote:
>
> Rework wxvf_suspend() and wxvf_resume() to handle interface lifecycle
> transitions safely under rtnl_lock() and eliminate resource races.
>
> In wxvf_suspend(), if the netdevice is running, invoke wxvf_close() to
> quiesce DMA engines, disable NAPI, and release IRQs/rings cleanly prior
> to clearing PCI bus mastering and disabling the device.
>
> In wxvf_resume(), avoid partial hardware re-initialization on active
> queues. If the device was running before suspend, defer complete queue
> and interrupt setup to a new reset subtask flag WX_FLAG_NEED_REOPEN,
> which safely invokes wxvf_open() under rtnl_lock(). Provide error
> unwinding inside wxvf_reopen_subtask() if re-opening fails.
>
> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
> Changelogs:
> v3:
> - Fix DMA-after-free and UAF races in wxvf_suspend() by invoking
>   wxvf_close() when running, ensuring DMA engines are stopped and
>   NAPI/IRQs/rings are cleanly freed before clearing PCI state.
> - Replace manual resource allocation in wxvf_resume() with deferred
>   reopening via WX_FLAG_NEED_REOPEN, scheduling wxvf_reopen_subtask() to
>   run full wxvf_open() sequence under rtnl_lock().
> - Move timer/work synchronization after rtnl_lock() release in
>   wxvf_suspend() to prevent service tasks from re-arming the timer.
> - Add error unwinding in wxvf_reopen_subtask() to set WX_STATE_DOWN,
>   clear bus mastering, and log errors if reopen fails.
> - Skip wxvf_link_config_subtask() when WX_STATE_DOWN is set to prevent
>   link updates on downed interfaces.
> v2: https://lore.kernel.org/netdev/20260829091423.83097-1-mengyuanlou@net=
-swift.com/
> - Refactored the suspend and resume logic to eliminate full netdevice clo=
se/open
>   cycles in favor of lightweight interrupt and queue manipulation:
>   * In wxvf_suspend(), replaced wxvf_close() with explicit queue stopping
>     (netif_tx_disable), carrier drop, NAPI disabling (wx_napi_disable_all=
), IRQ
>     releasing (wx_free_irq), and resource freeing (wx_free_resources).
>   * In wxvf_resume(), replaced wxvf_open() with granular resource allocat=
ion
>     (wx_setup_resources), MSI-X IRQ requesting (wx_request_msix_irqs_vf),=
 and deferred
>     hardware reconfiguration via WX_FLAG_NEED_DO_RESET flag.
> - Dropped the addition of device_link_add() to parent PF in ngbevf and tx=
gbevf probe()
>   paths to keep the patch focused strictly on libwx PM suspend/resume flo=
w.
> v1: https://lore.kernel.org/netdev/20260826095243.16939-1-mengyuanlou@net=
-swift.com/
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
>  .../net/ethernet/wangxun/libwx/wx_vf_common.c | 57 ++++++++++++++++++-
>  2 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/e=
thernet/wangxun/libwx/wx_type.h
> index 2eba5ab59925..1b18b069decc 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1288,6 +1288,7 @@ enum wx_pf_flags {
>         WX_FLAG_NEED_MODULE_RESET,
>         WX_FLAG_NEED_UPDATE_LINK,
>         WX_FLAG_NEED_DO_RESET,
> +       WX_FLAG_NEED_REOPEN,
>         WX_FLAG_RX_MERGE_ENABLED,
>         WX_FLAG_TXHEAD_WB_ENABLED,
>         WX_FLAG_NEED_PCIE_RECOVERY,
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/=
net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..3e55738e2096 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -16,9 +16,16 @@ int wxvf_suspend(struct device *dev_d)
>         struct pci_dev *pdev =3D to_pci_dev(dev_d);
>         struct wx *wx =3D pci_get_drvdata(pdev);
>
> +       rtnl_lock();
>         netif_device_detach(wx->netdev);
> +       if (netif_running(wx->netdev))
> +               wxvf_close(wx->netdev);
>         wx_clear_interrupt_scheme(wx);
> +       pci_clear_master(pdev);
>         pci_disable_device(pdev);
> +       rtnl_unlock();

Is the rtnl_lock() protection needed around pci_clear_master() and
pci_disable_device()?

> +       timer_delete_sync(&wx->service_timer);
> +       cancel_work_sync(&wx->service_task);

These should probably be moved up before
pci_clear_master/pci_disable_device and after the rtnl_unlock().

>
>         return 0;
>  }
> @@ -34,11 +41,25 @@ int wxvf_resume(struct device *dev_d)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev_d);
>         struct wx *wx =3D pci_get_drvdata(pdev);
> +       int err;
>
> -       pci_set_master(pdev);
> -       wx_init_interrupt_scheme(wx);
> -       netif_device_attach(wx->netdev);
> +       err =3D pci_enable_device_mem(pdev);
> +       if (err) {
> +               dev_err(&pdev->dev, "Cannot enable PCI device from suspen=
d\n");
> +               return err;
> +       }
>
> +       rtnl_lock();
> +       if (netif_running(wx->netdev)) {
> +               clear_bit(WX_STATE_DOWN, wx->state);
> +               clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
> +               mod_timer(&wx->service_timer, jiffies + HZ);
> +               set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +       } else {
> +               pci_set_master(pdev);
> +               netif_device_attach(wx->netdev);
> +       }
> +       rtnl_unlock();
>         return 0;
>  }
>  EXPORT_SYMBOL(wxvf_resume);
> @@ -388,6 +409,9 @@ static void wxvf_link_config_subtask(struct wx *wx)
>  {
>         struct net_device *netdev =3D wx->netdev;
>
> +       if (test_bit(WX_STATE_DOWN, wx->state))
> +               return;
> +
>         wxvf_watchdog_update_link(wx);
>         if (wx->link) {
>                 if (netif_carrier_ok(netdev))
> @@ -403,10 +427,37 @@ static void wxvf_link_config_subtask(struct wx *wx)
>         }
>  }
>
> +static void wxvf_reopen_subtask(struct wx *wx)
> +{
> +       if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
> +               return;
> +
> +       rtnl_lock();
> +       pci_set_master(wx->pdev);
> +       if (wx_init_interrupt_scheme(wx))
> +               goto out;
> +       if (wxvf_open(wx->netdev))
> +               goto out_clear_scheme;
> +       clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +       netif_device_attach(wx->netdev);
> +       rtnl_unlock();
> +       return;
> +
> +out_clear_scheme:
> +       wx_clear_interrupt_scheme(wx);
> +out:
> +       pci_clear_master(wx->pdev);
> +       clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
By clearing this on the error path, the VF tries once to establish
communication with the PF. What if the PF is not back up by that time?

> +       set_bit(WX_STATE_DOWN, wx->state);

And by setting this, the service_task which calls
wxvf_reopen_subtask() won't run again. So essentially on a 1 time
failure of the VF trying to talk to the PF, the VF gives up. I think
it is better for the VF to retry continuously(or at least a maximum
amount of times) to talk to the PF before giving up.

Also, it probably would be better to split up the patch into:
- rtnl_lock() protections
- implement a proper retry mechanism for establishing VF-PF communication.

> +       rtnl_unlock();
> +       dev_err(&wx->pdev->dev, "Failed to reopen device\n");
> +}
> +
>  static void wxvf_service_task(struct work_struct *work)
>  {
>         struct wx *wx =3D container_of(work, struct wx, service_task);
>
> +       wxvf_reopen_subtask(wx);
>         wxvf_link_config_subtask(wx);
>         wxvf_reset_subtask(wx);
>         wx_service_event_complete(wx);
> --
> 2.30.1
>
