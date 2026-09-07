Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31972D8385
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749297; cv=none; b=hNk2CSE2JSPnPLcTP2LwY2sepUKhYoJeYLoNQwbFtIyRs9b26y5J+m4uwfw+cU+YnKB14F1Qgf5k6/SVt0mki0lhcpyu9GLraXN11BVSgIv02DpQpzdYlG+k5occztr9kagyIvrtQQFVEAAT+AM7W5WY6VnIOTFx6oJ5L91NqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749297; c=relaxed/simple;
	bh=JeOUeRel/waGx59e530czBsOBREaLc1indiwLDuLaiQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o9bACzJdk9qpmHaZ57r85bDNJF4i+Zol1NIHjJIi+bS0JwbLVW32/UntGYTX8aJYKE1cScmbgwWSczqNJ6FrkzK7kqmnaqtH0/jG9XkU4lWUSGkIHYdgHvnvVWcc+Z5hZWGeh83V6vOifl52d7WvJQbGX1v9hZoKcYuu1UpBe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz4t1788749239t76a55e44
X-QQ-Originating-IP: B+mhxDsbronEmOZCF4kwbNEdGgzWEtB2Ohun3sLVH80=
Received: from smtpclient.apple ( [36.24.66.61])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Sep 2026 10:47:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4551967325457080571
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v3] net: libwx: fix PM suspend/resume flow for VF
 drivers
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <CAEAWyHfapofRa1qDXORqdO9+G+=U6P4-C5aEMnugYnwgn=6ZuQ@mail.gmail.com>
Date: Mon, 7 Sep 2026 10:47:05 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0138795D-2981-47B8-885C-8F117D82034E@net-swift.com>
References: <20260904085216.43469-1-mengyuanlou@net-swift.com>
 <CAEAWyHfapofRa1qDXORqdO9+G+=U6P4-C5aEMnugYnwgn=6ZuQ@mail.gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MBqHUE/VTFgzkkHiCDCcTXtnoygd+LxdGTXRD8PMDdHWd9wLe1YRcsiA
	Dj4SJebIxZqVniFx/r5JPNz1MlVKqelS8JdVYyyabb1TgAY9PhVa3Ucry2ZZpx2xFVu24uT
	yiENyySLLwR44Jbve6zVF5xYA4gtFUYBtsblOvh+snnHfh4MpwJB1s/NSZ3sx5aD2hwztKm
	uqVnjxmc1g0Q6RdeFbT9jf3aAuNrNngXF4ET6ptmVAruaEt6SIITfbAdDkViXVhiSpfsum8
	pfeG03+D91WEd72MugPTMIGXYscysHnQRWxCVRMo+hHxh4dn2PxtzrK8ndCWRBMt+VceS8Y
	sa755KJem6x5ACpvsWacrTaJaNzrx4UiUH3C3hoHI0OZ/q/CBGZyI8Bm7k04Jn7gfLCboaH
	jmPfMFu+kAqiEnuu8wIdMmDaeuFbDATmIYZ1rCzd/VXnIhssEFqiTFiwqKHzGWuVJPv9sAd
	GhJpNAiGfsv3p6LJFRZjaa8G3TYl6Bfcdm3HFdk3Jcx0hYyCPVnaqXl1Pqm41EDRk7mqIJR
	kAm866e0M4UNyGVxj+3mTwI+U+sO3KDA4t82jTX7uhRPT1SDBsZYlPMOd9LLAo/eYNWHhkz
	I6F+jP46D6rijpoeu61/qlHZ+Y1VmhxrG//isSswtXKrsUi0A8I0NmA89EpgrhUZtTzTyMu
	D9cz25jDn/WUfur3CAMFiAYwg8585L2CX8kF3TrMjKvX3vS6DaN0I6Xv8rOB9smaNwosGmC
	yJqUYPIWPz/hLDXUAUwt9hZbMH3ldfAXRQbBmaZ/jmG8E2IEgO08L/uKXK72417uAnRMrXh
	TU6wJJPd1h6IlPwb2Db9tUIT4JDBCdbRuvRKOxuirjUNV0x6tz5i6M7HbbvBAWP8wDCGD/G
	FcffD4K5pk2h0cMI8OaIXlFHHzpj9Ysbr+sGg0Qhn8kNp2V4vGPK42XKcEjmYLL4T5/LJLM
	G5FK3NZHRp1TFQTPhTUIqLW74+NRYd8PNWiutcHwwoE2y6dykMgYy0V/fLrzuZUssKHgvjU
	4UqJMGQhDyN0/zdj+YZcAVRzd996UBogmBWv1NUjHOwCxAG6M8Iaca2wdsJT2X0C1cCocTC
	vYundjP6P5Y
X-QQ-XMRINFO: OWPUhxQsoeAVphyDtyrRrLLv/PV+7Q6HHQ==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=885=E6=97=A5 09:56=EF=BC=8CHarshitha Ramamurthy =
<hramamurthy@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Sep 4, 2026 at 1:52=E2=80=AFAM Mengyuan Lou =
<mengyuanlou@net-swift.com> wrote:
>>=20
>> Rework wxvf_suspend() and wxvf_resume() to handle interface lifecycle
>> transitions safely under rtnl_lock() and eliminate resource races.
>>=20
>> In wxvf_suspend(), if the netdevice is running, invoke wxvf_close() =
to
>> quiesce DMA engines, disable NAPI, and release IRQs/rings cleanly =
prior
>> to clearing PCI bus mastering and disabling the device.
>>=20
>> In wxvf_resume(), avoid partial hardware re-initialization on active
>> queues. If the device was running before suspend, defer complete =
queue
>> and interrupt setup to a new reset subtask flag WX_FLAG_NEED_REOPEN,
>> which safely invokes wxvf_open() under rtnl_lock(). Provide error
>> unwinding inside wxvf_reopen_subtask() if re-opening fails.
>>=20
>> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> Changelogs:
>> v3:
>> - Fix DMA-after-free and UAF races in wxvf_suspend() by invoking
>>  wxvf_close() when running, ensuring DMA engines are stopped and
>>  NAPI/IRQs/rings are cleanly freed before clearing PCI state.
>> - Replace manual resource allocation in wxvf_resume() with deferred
>>  reopening via WX_FLAG_NEED_REOPEN, scheduling wxvf_reopen_subtask() =
to
>>  run full wxvf_open() sequence under rtnl_lock().
>> - Move timer/work synchronization after rtnl_lock() release in
>>  wxvf_suspend() to prevent service tasks from re-arming the timer.
>> - Add error unwinding in wxvf_reopen_subtask() to set WX_STATE_DOWN,
>>  clear bus mastering, and log errors if reopen fails.
>> - Skip wxvf_link_config_subtask() when WX_STATE_DOWN is set to =
prevent
>>  link updates on downed interfaces.
>> v2: =
https://lore.kernel.org/netdev/20260829091423.83097-1-mengyuanlou@net-swif=
t.com/
>> - Refactored the suspend and resume logic to eliminate full netdevice =
close/open
>>  cycles in favor of lightweight interrupt and queue manipulation:
>>  * In wxvf_suspend(), replaced wxvf_close() with explicit queue =
stopping
>>    (netif_tx_disable), carrier drop, NAPI disabling =
(wx_napi_disable_all), IRQ
>>    releasing (wx_free_irq), and resource freeing (wx_free_resources).
>>  * In wxvf_resume(), replaced wxvf_open() with granular resource =
allocation
>>    (wx_setup_resources), MSI-X IRQ requesting =
(wx_request_msix_irqs_vf), and deferred
>>    hardware reconfiguration via WX_FLAG_NEED_DO_RESET flag.
>> - Dropped the addition of device_link_add() to parent PF in ngbevf =
and txgbevf probe()
>>  paths to keep the patch focused strictly on libwx PM suspend/resume =
flow.
>> v1: =
https://lore.kernel.org/netdev/20260826095243.16939-1-mengyuanlou@net-swif=
t.com/
>> ---
>> drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
>> .../net/ethernet/wangxun/libwx/wx_vf_common.c | 57 =
++++++++++++++++++-
>> 2 files changed, 55 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h =
b/drivers/net/ethernet/wangxun/libwx/wx_type.h
>> index 2eba5ab59925..1b18b069decc 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
>> @@ -1288,6 +1288,7 @@ enum wx_pf_flags {
>>        WX_FLAG_NEED_MODULE_RESET,
>>        WX_FLAG_NEED_UPDATE_LINK,
>>        WX_FLAG_NEED_DO_RESET,
>> +       WX_FLAG_NEED_REOPEN,
>>        WX_FLAG_RX_MERGE_ENABLED,
>>        WX_FLAG_TXHEAD_WB_ENABLED,
>>        WX_FLAG_NEED_PCIE_RECOVERY,
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> index 26de78e9a69e..3e55738e2096 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> @@ -16,9 +16,16 @@ int wxvf_suspend(struct device *dev_d)
>>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
>>        struct wx *wx =3D pci_get_drvdata(pdev);
>>=20
>> +       rtnl_lock();
>>        netif_device_detach(wx->netdev);
>> +       if (netif_running(wx->netdev))
>> +               wxvf_close(wx->netdev);
>>        wx_clear_interrupt_scheme(wx);
>> +       pci_clear_master(pdev);
>>        pci_disable_device(pdev);
>> +       rtnl_unlock();
>=20
> Is the rtnl_lock() protection needed around pci_clear_master() and
> pci_disable_device()?
>=20
>> +       timer_delete_sync(&wx->service_timer);
>> +       cancel_work_sync(&wx->service_task);
>=20
> These should probably be moved up before
> pci_clear_master/pci_disable_device and after the rtnl_unlock().
ok

>=20
>>=20
>>        return 0;
>> }
>> @@ -34,11 +41,25 @@ int wxvf_resume(struct device *dev_d)
>> {
>>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
>>        struct wx *wx =3D pci_get_drvdata(pdev);
>> +       int err;
>>=20
>> -       pci_set_master(pdev);
>> -       wx_init_interrupt_scheme(wx);
>> -       netif_device_attach(wx->netdev);
>> +       err =3D pci_enable_device_mem(pdev);
>> +       if (err) {
>> +               dev_err(&pdev->dev, "Cannot enable PCI device from =
suspend\n");
>> +               return err;
>> +       }
>>=20
>> +       rtnl_lock();
>> +       if (netif_running(wx->netdev)) {
>> +               clear_bit(WX_STATE_DOWN, wx->state);
>> +               clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
>> +               mod_timer(&wx->service_timer, jiffies + HZ);
>> +               set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
>> +       } else {
>> +               pci_set_master(pdev);
>> +               netif_device_attach(wx->netdev);
>> +       }
>> +       rtnl_unlock();
>>        return 0;
>> }
>> EXPORT_SYMBOL(wxvf_resume);
>> @@ -388,6 +409,9 @@ static void wxvf_link_config_subtask(struct wx =
*wx)
>> {
>>        struct net_device *netdev =3D wx->netdev;
>>=20
>> +       if (test_bit(WX_STATE_DOWN, wx->state))
>> +               return;
>> +
>>        wxvf_watchdog_update_link(wx);
>>        if (wx->link) {
>>                if (netif_carrier_ok(netdev))
>> @@ -403,10 +427,37 @@ static void wxvf_link_config_subtask(struct wx =
*wx)
>>        }
>> }
>>=20
>> +static void wxvf_reopen_subtask(struct wx *wx)
>> +{
>> +       if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
>> +               return;
>> +
>> +       rtnl_lock();
>> +       pci_set_master(wx->pdev);
>> +       if (wx_init_interrupt_scheme(wx))
>> +               goto out;
>> +       if (wxvf_open(wx->netdev))
>> +               goto out_clear_scheme;
>> +       clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
>> +       netif_device_attach(wx->netdev);
>> +       rtnl_unlock();
>> +       return;
>> +
>> +out_clear_scheme:
>> +       wx_clear_interrupt_scheme(wx);
>> +out:
>> +       pci_clear_master(wx->pdev);
>> +       clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> By clearing this on the error path, the VF tries once to establish
> communication with the PF. What if the PF is not back up by that time?
>=20
>> +       set_bit(WX_STATE_DOWN, wx->state);
>=20
> And by setting this, the service_task which calls
> wxvf_reopen_subtask() won't run again. So essentially on a 1 time
> failure of the VF trying to talk to the PF, the VF gives up. I think
> it is better for the VF to retry continuously(or at least a maximum
> amount of times) to talk to the PF before giving up.
>=20
> Also, it probably would be better to split up the patch into:
> - rtnl_lock() protections
> - implement a proper retry mechanism for establishing VF-PF =
communication.
>=20

Error handling is indeed very important and requires careful =
consideration.
Thanks.

>> +       rtnl_unlock();
>> +       dev_err(&wx->pdev->dev, "Failed to reopen device\n");
>> +}
>> +
>> static void wxvf_service_task(struct work_struct *work)
>> {
>>        struct wx *wx =3D container_of(work, struct wx, service_task);
>>=20
>> +       wxvf_reopen_subtask(wx);
>>        wxvf_link_config_subtask(wx);
>>        wxvf_reset_subtask(wx);
>>        wx_service_event_complete(wx);
>> --
>> 2.30.1


