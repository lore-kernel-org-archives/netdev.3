Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F13BB113
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821759; cv=none; b=dUac7WBHGy6fDsyd2ccr9FOZ1QfGsTRzhuHvootwsnewnmQgEL1Sc32r0m9rcfh7uxCIG8L+NIci46W3uDMVCPpFAAlFBdUyJlgdAonJ3CohZU4Ky1zv+UJTmcLTeKu+sQe6UNo1ZyHds6FOEI32gYA3yKzwlZ+PFztQpsAweMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821759; c=relaxed/simple;
	bh=nm3i+GjmpMFUoTcQO0ptVNCqpBf+DZEquh1+BwAStjc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EIw3AFZvhNOeCjavt6fttRXhfvkCafxDhSBa9ACFdXW6hh/6dvHpOA7fNK3+WAmKTVFFddJGKZbtKv6yf6q+czvL+Ug8Elhjq+RWUwBuXctrl1QDHk/Jh90fIpjdFM/i6itlMQwHQjB1xDDuDlmNcVRnaXXqMDNo8QZ2BfqqnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz17t1787821696t2ff67989
X-QQ-Originating-IP: aeoXvOO4AYqWroKLjFEs+hovkmWC4rrJQH8Mu+/upW4=
Received: from smtpclient.apple ( [122.233.170.62])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 17:08:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15438221679702872010
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net] net: libwx: Fix PM suspend/resume flow for VF drivers
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <CAEAWyHf4bVm_DQbLo=Q1NwJ2g5WY2HU7Y+ApndDHdAbEDnfk4g@mail.gmail.com>
Date: Thu, 27 Aug 2026 17:07:51 +0800
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
Message-Id: <8875A5CE-3A34-4227-B06B-34E8292D19F5@net-swift.com>
References: <20260826095243.16939-1-mengyuanlou@net-swift.com>
 <CAEAWyHf4bVm_DQbLo=Q1NwJ2g5WY2HU7Y+ApndDHdAbEDnfk4g@mail.gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NY7N4KDmsCacniHqki94FDIeaJbjaWJZXznfTUR1YeX3tweh0UfYb0eR
	IKJrF18Woi8sMBQMLinXKRJjL1UEb104UQV+x6stnAqyMA06YmM/eXJEwA/Y+3qVo+afIXP
	1UdpTh+j8IFQvvsrHqoMGNYccZF7o4l10fQYTKdf7CuMh16KXU6GU9p/GCSKtZ95zRpfTvS
	Z6Qj8tonYiWgMmtlfuh0uAqZGwmT6f43LR/daIGjTOKU31klXtpSd6uPBX4lKamRDueuDaF
	V7ZhVVCyDYU2O94oeIR84U6htybweT5SCdyyQOABlHvQ3W0MRBJyHrVX0opnCnz8HnGO7mP
	Rnt+C+pvmDZyg+CrqZ8st8rv4C4obmKQ7pYUgW0+77XhRhCt9GnoLlbDcZ2g56Qq7PHcffW
	VATTtV430LV5FrajUqjY14qEzKoOFtGPkNnh9yfVoIZ+lepdN3DpsFUoULZuY3xwHaJjQwP
	HlFQfnv60TqNgUVT23r6JFp2w/LIBEZoU4iS27aFkaz8xgPKMCZ4+yFOEswOnV2YmdAg4BH
	LC9RG75pzcPI0MC+TuvKhwpiy4T+RoBgcT9+aKoGNvxyhOW5OO/nG1kEj920DtkshToq5Xd
	TjB5cn1/DRyiDqtIcJzbf/MDRkOhwUN7NrBsllSYSyD+My8QSzSTagtJ4nKWnygkcPH+WXN
	idxTa5O8KVLJOIaT9E1THjOe2KeVpOeABsb/KdM7SaSHHql/SHP3kCHV1IxUZink33tsfSg
	OJsXYpxcjy/h05imhVRg3bqYubLaWfq5pZFfchbr1WO1B1B3Nuv/HRcvdqByhXb4FL0gxi/
	6W1fRBwaM+4kC+NTofKbCEOVAzLKoY5pyAA70CmPuK6HrifvPta/zv4miJbnDwNwi4RqRn1
	OzdGySfv1EQP0xW0c5KEXKkmFHyAGJMQL3mzZAeIgC58SkRCOro9OqcNLSHp6m3sHmWkY/W
	gVPVVrxDQXe0TlNcmeO+r+daKpxtKXar8jKyeRPxnRpGR4XNnn5hWvdVwEu/r/PWoFajHjt
	c2K1mz3F8FMOuH47AZofPKtzdRDzDhvx9PNfimnDlKX27vi0BILb+Fks6jEldxzlSbSzuc/
	XdGDyerBd6mTF2tGv3TDeM=
X-QQ-XMRINFO: Nq+8W0+stu50ZnsSE8K0tl4AWNuJxP2pTA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B48=E6=9C=8827=E6=97=A5 08:41=EF=BC=8CHarshitha Ramamurthy =
<hramamurthy@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Aug 26, 2026 at 3:01=E2=80=AFAM Mengyuan Lou =
<mengyuanlou@net-swift.com> wrote:
>>=20
>> Currently, wxvf_suspend() and wxvf_resume() do not acquire the RTNL
>> lock during device state transitions, which can lead to race =
conditions
>> with network interface configuration operations. Furthermore, the VF =
PM
>> callbacks lack proper hardware re-initialization and error handling,
>> leading to potential unhandled errors during PM resume and missing
>> dependency tracking between VF and PF devices.
>>=20
>> Fix these issues with the following changes:
>>=20
>> 1. Hold rtnl_lock() around suspend and resume paths to synchronize =
netdev
>>   state modifications with RTNL core operations.
>> 2. In wxvf_suspend(), close the netdevice before disabling PCI device =
and
>>   clearing interrupt schemes to ensure clean resource teardown.
>> 3. In wxvf_resume(), check PCI device enablement errors and perform =
proper
>>   error unwinding if interrupt scheme re-initialization or interface =
open
>>   fails.
>> 4. Add device links between VF and its parent PF device in probe() =
for both
>>   ngbevf and txgbevf to enforce correct power management ordering.
>=20
> This patch is trying to do a few too many things.
>=20
>>=20
>> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
>=20
> The patch adds code to ngbevf/ngbevf_main.c but the Fixes: tag is for
> a txgbevf commit....
>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> .../net/ethernet/wangxun/libwx/wx_vf_common.c | 30 =
++++++++++++++++++-
>> .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  5 ++++
>> .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  5 ++++
>> 3 files changed, 39 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> index 26de78e9a69e..2352cf12b289 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>> @@ -16,9 +16,13 @@ int wxvf_suspend(struct device *dev_d)
>>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
>>        struct wx *wx =3D pci_get_drvdata(pdev);
>>=20
>> +       rtnl_lock();
>>        netif_device_detach(wx->netdev);
>> +       if (netif_running(wx->netdev))
>> +               wxvf_close(wx->netdev);
>>        wx_clear_interrupt_scheme(wx);
>>        pci_disable_device(pdev);
>> +       rtnl_unlock();
>>=20
>>        return 0;
>> }
>> @@ -34,12 +38,36 @@ int wxvf_resume(struct device *dev_d)
>> {
>>        struct pci_dev *pdev =3D to_pci_dev(dev_d);
>>        struct wx *wx =3D pci_get_drvdata(pdev);
>> +       int err;
>> +
>> +       err =3D pci_enable_device_mem(pdev);
>> +       if (err) {
>> +               dev_err(&pdev->dev, "Cannot enable PCI device from =
suspend\n");
>> +               return err;
>> +       }
>>=20
>>        pci_set_master(pdev);
>> -       wx_init_interrupt_scheme(wx);
>> +       rtnl_lock();
>> +
>> +       err =3D wx_init_interrupt_scheme(wx);
>> +       if (err)
>> +               goto err_pci;
>> +
>> +       if (netif_running(wx->netdev)) {
>> +               err =3D wxvf_open(wx->netdev);
>=20
> Don't you need to reset the VF before attempting the open?

It is not necessary.

>=20
>> +               if (err)
>> +                       goto err_clear_int;
>> +       }
>>        netif_device_attach(wx->netdev);
>> +       rtnl_unlock();
>>=20
>>        return 0;
>> +err_clear_int:
>> +       wx_clear_interrupt_scheme(wx);
>> +err_pci:
>> +       rtnl_unlock();
>> +       pci_disable_device(pdev);
>> +       return err;
>> }
>> EXPORT_SYMBOL(wxvf_resume);
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c =
b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
>> index d79cf8d8484f..69bbfd95597c 100644
>> --- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
>> +++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
>> @@ -171,6 +171,11 @@ static int ngbevf_probe(struct pci_dev *pdev,
>>                goto err_pci_release_regions;
>>        }
>>=20
>> +       if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
>=20
> Accessing pdev->physfn here from a VF will cause a kernel panic inside
> VMs. Also creating device links to the PF is odd. The PF should manage
> its own PM state.

Yeah, you are right.=20

But my problem is that when both PF and VFs all in host, VFs resume =
before than PF.
VFs can not work if PF is not up.

Are there any good methods? Solve this problem by itself in the pf =
resume.


[24500.725614] smpboot: Booting Node 0 Processor 23 APIC 0x1b
[24500.730077] CPU23 is up
[24500.733353] ACPI: PM: Waking up from system sleep state S3
[24500.842648] ngbevf 0000:07:00.0: enabling device (0000 -> 0002)
[24500.843113] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for =
VF.
[24500.843144] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for =
VF.
[24500.843185] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for =
VF.
[24500.844013] serial 00:00: activated
[24500.853861] ngbevf 0000:07:00.0: Could not enable Tx Queue 0
[24500.853909] ngbevf 0000:07:00.0: Failed to obtain mailbox lock for =
VF.
[24500.864810] ngbevf 0000:07:00.0: RRCFG.EN on Rx queue 0 not set =
within the polling period
[24500.874722] nvme nvme0: 24/0/0 default/read/poll queues
[24500.904063] ngbe 0000:06:00.1 enp6s0f1: PHY [ngbe-601:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[24500.904598] ngbe 0000:06:00.1: registered PHC device on enp6s0f1
[24500.904836] ngbe 0000:06:00.1 enp6s0f1: configuring for =
phy/rgmii-rxid link mode
[24500.950076] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[24500.950509] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
[24500.950549] ngbe 0000:06:00.0 enp6s0f0: configuring for =
phy/rgmii-rxid link mode
[24500.971368] ngbe 0000:06:00.0: Failed to obtain mailbox lock for PF0
[24501.000057] r8169 0000:08:00.0 enp8s0: Link is Down
[24501.053774] OOM killer enabled.
[24501.053775] Restarting tasks: Starting
[24501.055611] Restarting tasks: Done
[24501.055623] efivarfs: resyncing variable state
[24501.059625] efivarfs: finished resyncing variable state
[24501.059651] random: crng reseeded on system resumption
[24501.059656] PM: suspend exit
[24501.151222] ata2: SATA link down (SStatus 0 SControl 300)
[24501.151329] ata1: SATA link down (SStatus 0 SControl 300)
[24504.026452] ngbe 0000:06:00.0: Failed to obtain mailbox lock for PF0
[24504.026461] ngbe 0000:06:00.0 enp6s0f0: Link is Up - 1Gbps/Full - =
flow control rx/tx
[24504.230844] r8169 0000:08:00.0 enp8s0: Link is Up - 1Gbps/Full - flow =
control rx/tx



>=20
>> +                            DL_FLAG_PM_RUNTIME | =
DL_FLAG_AUTOREMOVE_CONSUMER))
>> +               dev_warn(&pdev->dev, "Failed to create device link to =
PF %s\n",
>> +                        pci_name(pdev->physfn));
>> +
>>        SET_NETDEV_DEV(netdev, &pdev->dev);
>>=20
>>        wx =3D netdev_priv(netdev);
>> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c =
b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
>> index 8b16b900820a..3868b70ad152 100644
>> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
>> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
>> @@ -228,6 +228,11 @@ static int txgbevf_probe(struct pci_dev *pdev,
>>                goto err_pci_release_regions;
>>        }
>>=20
>> +       if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
>> +                            DL_FLAG_PM_RUNTIME | =
DL_FLAG_AUTOREMOVE_CONSUMER))
>> +               dev_warn(&pdev->dev, "Failed to create device link to =
PF %s\n",
>> +                        pci_name(pdev->physfn));
>> +
>>        SET_NETDEV_DEV(netdev, &pdev->dev);
>>=20
>>        wx =3D netdev_priv(netdev);
>> --
>> 2.30.1


