Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7F12B94;
	Fri,  7 Aug 2026 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084753; cv=none; b=llHXI/O79q0pM6wpVp/QppSWT4ozt6OtI0a+kFdoT6onlJboPZ5y0LEdknb3bN058rp7UHNI1ZNuUnK/rh2Lws/1i8LXMZ0b5srOlF3ZT4kdvPVirVcfH7jrYO2y2J9GSVs2aoEjuxkN58Ozwag5uDKGYv2TP5Sb3dJCyxmLPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084753; c=relaxed/simple;
	bh=TG/NqxHidDLcV6kQpboNPww5RI1M1P+rlw1iUy1zMHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtSQK2nfxQSxxxEDx43RLb4QK1vked+2YpZI6KkI4L4M5h298bLfRplTygDsQ18P/7tj3g4d1NNC3WFnX/lizPBCF6UWW2BmViGwQ6FsQmmRCFJYfb9pLnaZlLjapjzMLZs3+ba8yckJymNY0dSqswN7whWFyrF+fXJ/Xzlrwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vOjubb06; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M9Il4MdW; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vOjubb06";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M9Il4MdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786084749;
	bh=TG/NqxHidDLcV6kQpboNPww5RI1M1P+rlw1iUy1zMHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOjubb06eMdoTe3RmV+AMbYwsdJxyMSnQfeVjEUa5L8I0+hl0DBoe1V0XZvRd3cDH
	 a6Pb+P+D6ioczXUBd3K3AoyR9YFY7ym8PrIV4dz0G2QuvryByG7hxCFf162gi2nwh5
	 PIt7QSJ5ZmGlfb4kPlS/GMPGzEutDkZwdayvgkNXphG+SxjcIr3iRM2Ef8GYqITJ4R
	 5cV4ZRR1rQGPJ8LTLX8TrAj6d8Zq35EdlAt0Om1RbDYSsQzKOhofiJ3TIbApvJ/79Q
	 uMbEKfhAWNq92AUtbx47HaPoV3TjtBxSJnbTWhoCoWTZEM27OjpulSmoepS2qIrV7b
	 4/W31UrYzIyKg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D3F53496FB; Fri,  7 Aug 2026 06:39:09 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786084743;
	bh=TG/NqxHidDLcV6kQpboNPww5RI1M1P+rlw1iUy1zMHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9Il4MdWvhUuLQZK2ejcgyvlrFrVG5MJ/qGviNcGDv+TZ4F51d+KXjHlbRjo5HRYE
	 +P0e9KYGdhfm/LwhXUzjyAqdcOE4MeiTUZxQYRFjK3lEP1YCGtE6f2ekhhEmtRCq1U
	 6by2VpD7cm3iTsMqU2GuIg70snEHJBzgA6B1dDh002Z4KhdehTbsnfNk5Suw6ENbX2
	 JWDkwLnwO3KmqPLH7YCiimKsE85VLdLbXjezpSS7pQlLyoiwJpvDoPWkKi5t7LFNQc
	 fRqonUZVqgfxPtKsHrUycW81cWrwfxon6D4DPWRTTwyiqdsQGlBfxvXiSFagAOwE+a
	 8ZgujGqjY9sfQ==
Received: from [10.30.1.58] (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3CB2D496F5;
	Fri,  7 Aug 2026 06:39:03 +0000 (UTC)
Message-ID: <7a91e550-ac70-4423-9aed-9f4406e71fe8@birger-koblitz.de>
Date: Fri, 7 Aug 2026 08:39:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
 <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
 <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2026 23:16, Andrew Lunn wrote:
>>>> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
>>>> +{
>>>> +	bool adv_2500;
>>>> +	int ret;
>>>> +
>>>> +	if (phydev->autoneg == AUTONEG_DISABLE) {
>>>> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>> Why is that? Now that phylink is driving the PHY, and reporting
>>> speeds, duplex etc, you should have everything you need to program the
>>> MAC when the link mode is forced.
>>>
>> I tried forcing the PHY speed in the past, and it does not work.
>> This is a limitation which is also acknowledged for the suspected underlying PHY
>> hardware Airoha EN8811H, see the head of air_en8811h.c
> 
> How well does this unwind on error? Is phydev->autoneg put back to the
> old state to indicate autoneg is used?
> 
> This is one of the areas where phylib/phylink is missing a bit of
> support infrastructure. We have a bit indicating the PHY support
> autoneg, ETHTOOL_LINK_MODE_Autoneg_BIT, but there is no bit
> ETHTOOL_LINK_MODE_Force_BIT, indicating the PHY supports forced
> mode. So the core cannot enforce this and reject it in
> ksettings_set().
The error is handled quite poorly:
$ sudo ethtool -s enx6c6e07090000 autoneg off speed 1000
$ ip a
shows link is down

Kernel log:
[848763.836126] Asix Electronics AX88279 usb-004:045:03: Disabling autoneg is not supported
[848763.836134] ------------[ cut here ]------------
[848763.836137] _phy_start_aneg+0x0/0xa0: returned: -22
[848763.836142] WARNING: drivers/net/phy/phy.c:1352 at _phy_state_machine+0x100/0x310, CPU#8: kworker/8:1/534588
[848763.836146] Modules linked in: ax88179_178a cdc_mbim cdc_ncm ax88179(OE) ax88796b(OE) cdc_ether phylink(OE) r8152 nfnetlink_queue nfnetlink_log cdc_wdm usbnet mii sd_mod scsi_mod scsi_common 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm qrtr rfcomm algif_hash algif_skcipher af_alg bnep binfmt_misc nls_ascii nls_cp437 vfat fat amd_atl snd_acp_legacy_mach snd_acp_mach intel_rapl_msr 
snd_soc_nau8821 intel_rapl_common snd_acp3x_rn snd_soc_dmic snd_acp3x_pdm_dma snd_sof_amd_rembrandt snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_pci_ps edac_mce_amd iwlmvm 
snd_soc_acpi_amd_match snd_soc_acpi_amd_sdca_quirks snd_amd_sdw_acpi kvm_amd soundwire_amd btusb soundwire_generic_allocation btmtk mac80211 soundwire_bus btrtl kvm snd_soc_sdca snd_hda_codec_conexant 
btbcm snd_hda_codec_generic btintel snd_hda_codec_atihdmi snd_soc_core snd_hda_codec_hdmi snd_compress snd_hda_intel snd_pcm_dmaengine libarc4 irqbypass snd_hda_codec aesni_intel snd_acp_pci bluetooth 
snd_ctl_led gf128mul snd_amd_acpi_mach
[848763.836238]  iwlwifi snd_hda_core snd_acp_legacy_common think_lmi rapl snd_intel_dspcfg snd_pci_acp6x ecdh_generic snd_intel_sdw_acpi snd_pci_acp5x firmware_attributes_class wmi_bmof pcspkr 
snd_hwdep thinkpad_acpi cfg80211 snd_pcm nvram snd_rn_pci_acp3x snd_timer sparse_keymap snd_acp_config ee1004 snd snd_soc_acpi ccp k10temp snd_pci_acp3x rfkill ac soundcore amd_pmc joydev uvcvideo 
evdev videobuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc msr i2c_dev ecryptfs parport_pc ppdev lp dm_mod parport efi_pstore configfs nfnetlink efivarfs ip_tables 
x_tables autofs4 ext4 mbcache jbd2 crc32c_cryptoapi amdgpu drm_buddy amdxcp drm_panel_backlight_quirks gpu_sched drm_ttm_helper ttm drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper 
hid_multitouch cec hid_generic ucsi_acpi typec_ucsi rc_core nvme xhci_pci i2c_hid_acpi typec i2c_hid drm_client_lib sp5100_tco xhci_hcd roles hid drm_kms_helper psmouse r8169 watchdog nvme_core video 
thunderbolt usbcore i2c_piix4 realtek nvme_keyring
[848763.836342]  serio_raw drm nvme_auth phy_package crc16 i2c_smbus usb_common wmi battery button [last unloaded: ax88796b(OE)]
[848763.836359] CPU: 8 UID: 0 PID: 534588 Comm: kworker/8:1 Tainted: G  R     W  OE       7.1.3+deb13-amd64 #1 PREEMPT(lazy)  Debian 7.1.3-1~bpo13+1
[848763.836365] Tainted: [R]=FORCED_RMMOD, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[848763.836367] Hardware name: LENOVO 21JR005UGE/21JR005UGE, BIOS R2CET38W(1.20 ) 07/29/2024
[848763.836371] Workqueue: events_power_efficient phy_state_machine
[848763.836374] RIP: 0010:_phy_state_machine+0x102/0x310
[848763.836377] Code: 00 00 00 48 89 df 41 bc 01 00 00 00 e8 87 f8 ff ff 48 c7 c6 c0 63 1b 9b 83 f8 ed 74 79 85 c0 79 46 48 8d 3d 60 7a 7b 01 89 c2 <67> 48 0f b9 3a 48 8d bb 68 05 00 00 e8 2d dc 65 ff 
84 c0 0f 84 a7
[848763.836380] RSP: 0018:ffffd18e8baebe18 EFLAGS: 00010282
[848763.836383] RAX: 00000000ffffffea RBX: ffff88d4e0359800 RCX: 0000000000000000
[848763.836386] RDX: 00000000ffffffea RSI: ffffffff9b1b63c0 RDI: ffffffff9c96e5b0
[848763.836387] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[848763.836390] R10: 727463656c452078 R11: 656c452078697341 R12: 0000000000000001
[848763.836391] R13: ffff88d442ec9b80 R14: ffff88d4e0359d10 R15: 0000000000000000
[848763.836393] FS:  0000000000000000(0000) GS:ffff88d801d16000(0000) knlGS:0000000000000000
[848763.836396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[848763.836398] CR2: 00007f20af9bd943 CR3: 000000023bd5a000 CR4: 0000000000f50ef0
[848763.836400] PKRU: 55555554
[848763.836402] Call Trace:
[848763.836405]  <TASK>
[848763.836411]  phy_state_machine+0x28/0x50
[848763.836415]  process_one_work+0x198/0x390
[848763.836421]  worker_thread+0x1af/0x320
[848763.836425]  ? __pfx_worker_thread+0x10/0x10
[848763.836429]  kthread+0xe3/0x120
[848763.836432]  ? __pfx_kthread+0x10/0x10
[848763.836435]  ret_from_fork+0x2ba/0x340
[848763.836439]  ? __pfx_kthread+0x10/0x10
[848763.836442]  ret_from_fork_asm+0x1a/0x30
[848763.836449]  </TASK>
[848763.836451] ---[ end trace 0000000000000000 ]---
[848763.836458] ax88179 4-1:1.0 enx6c6e07090000: phy link down 2500base-x/1Gbps/Full/none/rx/tx/nolpi
[848763.836489] ax88179 4-1:1.0 enx6c6e07090000: Link is Down
[848764.571154] r8152 4-2:1.0 enx00e04c680000: carrier off


$ sudo ethtool -s enx6c6e07090000 autoneg on
Does not recover.

Birger
