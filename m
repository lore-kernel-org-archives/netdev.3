Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258480;
	b=0XpSXGkXjzg4dLDYbDh/InDFCGwgb5bjYKFrk287LrcW46C+x+jUK1a6ICIHKv/3oBaN
	 Vhr8CZrYosY5zfLDkr3xTuZyjYBM+Vk7o+gsgzocIWMuvhAjmFisON0AMW2E+arbO8Z++
	 GKqwgM6z1o4eu1b4/uMu5YsN3XbheVg0ZUOnggaKlofv2eltLrSp+75Ev4GnoHcFc3c1O
	 RAga6kCVJoUimfgBGouk5H2vTf2Gsi1Vt2GkhtBe5da88mfTivWjlt3LbZVsnB7Btfo8s
	 etyf5IcOUflQefYpx1SziGhzSTHjqdy7+SoYiCxykT3X9AaLGX0nwBTmvIV3BqKjYHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MKKXohUByD6XMZF0v5P3sIb1vGCKR1XCnr5lVTI09ZQ=;
	b=quOTN73bufw6XMebAfQaD4r+bezv56zGEOSoSaRxn7fKyGy6CQ/0DkZEeeqOpLGZpgAw
	 BnoaGEmqE5dxe7o3sP5wKiLGno6ZNbm/0Aj4REHgqYw+jLtKxwVIfZian3f+JN46pgmPy
	 ztfhElhP6Wzi+CQdNlIUgHk6pGvl2F23RZarjsfh91spWBJkWmCLU9ar2wKIrvKxjTyIo
	 QXAAT0ZWfGO2tuSn/piri22xjkkP+uJeh9TEzi9dl7m/gno7hVth1m+jk8DIcxMM2Sxa7
	 F4vvj/IVXlgKs4C380eUxeWBybYqK3MWxI7nihDF2stFGKx6J32wC2oTuXxynDDYf9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uESAZTQQ;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80406606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80406606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uESAZTQQ
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b70d5b07faso1658226a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794258479; x=1794863279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKKXohUByD6XMZF0v5P3sIb1vGCKR1XCnr5lVTI09ZQ=;
        b=uESAZTQQ5nGJKcbHebkV1DCiq87zSl00P4ma3hXB47EcrNb7BsgQezW9770Xu6wu+8
         oFXBiTJ5M4iTLU1/2x9CZxY+fnL9D3IsF20Ja5l4+oi6FnEgqpPXZQBMG3GgzmEKY7uk
         RifAbP9EmkOABCgQjwVGDokKS/CeTPjCzflmfxRTuzlCeU0Cw9ziVHlVUaMEWT9Xn7c7
         L1UMbkor57w6v4GI7uJwmlW9CADx2nLLPBNqQ63s/GqA6OHDuZG18kNvB6QRTG65Q1rW
         CNSuFRKtb1DXSwLU0w42LQ/zZObHG4Qq6BMGH5bUrovsHXrbx3ZhR7asaEXUlhB/9+hL
         sdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258479; x=1794863279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKKXohUByD6XMZF0v5P3sIb1vGCKR1XCnr5lVTI09ZQ=;
        b=F9MqegpOgcRaKiE9w+/D1vWf6+jeF15PE5WHfVXry12sdW+cVEVa/vlO0jI/sPtDDL
         k1uWwCb9kAx0imGiJyy93nu5wK2kg27mYxd6mg61Noo1XKs6MODOM6q/QWyEeKtrZggM
         HbbaLUd5tGqHF9G0e8WOaPUs8J6LnCRNtQwep/AUXKPpKU6lGjhNtk0VaWR7iZ73VZsz
         W8dVzvd1fhjOsFiUONPzIRq5i9yEypD+4MSxccOLKm9l7+rKGRWX7zl7lsdM9t4heAqZ
         Z7JJQt4to8oIzNO125GsCfwrWOiRJpLitFFG6Hpyxh9yTgS3TB1y3vdzi/tvPnc+h5HI
         CfHQ==
X-Forwarded-Encrypted: i=1; AL+hErEiuzC+kfFL3nddSUHOcBDKi0yu7xfVo8xskVjGCTLgFiJGIAniEgVdTuf/6YB8B+VmpX+43pQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PA1T77YZ4LKl2SNddgd0iBmAsO8AEr5c9guEh4htDULQzIOVH
	+of8+WkZmWR1M5TF1MO9lAJ4y6DoLk/O2RXMR+zdZMDW6zKIO6H+V3fw
X-Gm-Gg: AYBFou3tuQ1W8WW07i6kv+hKAXc96z5GFRpgmTxxXDsEh2CLkMmX0+nBEpkWzIulgFz
	JWaSj7QgY3K6U4uejCOP06aaSGpuc2qNH+reLzbQuWhe9uIuCVJQeUJvfyD0OWQ2RZfhSYB5Oxw
	jWz6jUAFoPupvyY55pnIIy7RCTYzJd1JBPXL8AwQNU0r7gRwXCZ1ftcj969aD32q94jCaLZUM3g
	/yMLtpmmkDWHxEoJVZyUe8KnDmQExHfT45wexDmFvptBOawCncNmmaH4PslzHC8Mu/q7dPB81BA
	MMC7DwTpEUyI7scxOm8jSdTYpckMIbqiJGgrM0xBQSaZQgzv43U9pP1imHLbxJTAXehRWQhpxxy
	yqt/1APvcc51Ujyxi458MuE/xxgvQoLwi5ctnHjxHQR/nsm58nOAoglLPEc4KFeFN81DKVTJjc1
	710hbpYuD9jkinCk/qJSdnVq5QL6UPjutXZ7s8zKULWNxAbG9eOSnpkCyB0jnTorpfQzFiSR4z/
	RB63r3OBNuU2Cjwlvr7aSyT9ErpHs4PHco1dlNVK3I1wQCLyLtKcQSod3bJIa4C1O/yJG6/xl2C
	tN7EzWQ0bou+7t2uBnsR6518ppeDT3bpNFiw5bwYt3PnvfV33r/MDjDFJw2HquI3Qy2e5Tgr7KD
	kfqrmSOSHACTaTyxTTKvZRFirXIwcqhsBb18rEULKarzs8US7fmDvcFeuT7JGZnZNHj0=
X-Received: by 2002:a17:906:f58d:b0:c41:cf68:bbcf with SMTP id a640c23a62f3a-c50496543d9mr42038966b.32.1794258478794;
        Mon, 09 Nov 2026 13:07:58 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2d:9200:d1de:ab1d:3784:8084? (p200300ea8f2d9200d1deab1d37848084.dip0.t-ipconnect.de. [2003:ea:8f2d:9200:d1de:ab1d:3784:8084])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757902dbasm154309a12.30.2026.11.09.13.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:07:57 -0800 (PST)
Message-ID: <e2ba565a-f946-4d4c-b7fc-65e86b723ad1@gmail.com>
Date: Mon, 9 Nov 2026 22:07:56 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net sysfs: remove deprecated empty wireless
 directory
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, horms@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <2af5fc30-4520-4768-bcdb-7b1058b39212@gmail.com>
 <179425685052.994134.18203088192324473037@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <179425685052.994134.18203088192324473037@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09.11.2026 21:40, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch removes the empty /sys/class/net/<iface>/wireless
>   directory, which userspace can see.
> - [Medium] The removed wireless_group_needed() matched WEXT-only netdevs,
>   i.e. those with `ndev->wireless_handlers` set and no cfg80211…
> - [Low] The kernel-doc for struct net_device::sysfs_groups in
>   include/linux/netdevice.h still says "Space for optional device,…
> 
> --
> 
> net sysfs: remove deprecated empty wireless directory
> 
> This patch removes the empty "wireless" attribute group that
> netdev_register_kobject() created for cfg80211 and wireless extensions
> netdevs. It also shrinks net_device::sysfs_groups from 5 entries to 4.
> 
> Link: https://github.com/fedora-sysv/initscripts/commit/4e96fcecee7ab70295a5f2c52748cd57cbab60bb
> 
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 435be7880d7e5..ac943798abca6 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -2484,7 +2484,7 @@ struct net_device {
>>  	struct dm_hw_stat_delta __rcu *dm_private;
>>  #endif
>>  	struct device		dev;
>> -	const struct attribute_group *sysfs_groups[5];
>> +	const struct attribute_group *sysfs_groups[4];
> 
> [Severity: Low]
> This isn't a bug, but should the kernel-doc for this field be updated as
> well? It still says:
> 
>  *	@sysfs_groups:	Space for optional device, statistics and wireless
>  *			sysfs groups
> 
> After this patch, netdev_register_kobject() stores only the optional
> driver group, netstat_group, netdev_phys_group and the NULL terminator.
> The comment still lists a wireless slot that nothing fills, and it does
> not mention the phys group.
> 
>>  	const struct attribute_group *sysfs_rx_queue_group;
>>  
>>  	const struct rtnl_link_ops *rtnl_link_ops;
>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>> index 5c0402389c6d1..cb8c82d1a4da8 100644
>> --- a/net/core/net-sysfs.c
>> +++ b/net/core/net-sysfs.c
>> @@ -910,28 +910,6 @@ static const struct attribute_group netstat_group = {
>>  	.attrs  = netstat_attrs,
>>  };
>>  
>> -static struct attribute *wireless_attrs[] = {
>> -	NULL
>> -};
>> -
>> -static const struct attribute_group wireless_group = {
>> -	.name = "wireless",
>> -	.attrs = wireless_attrs,
>> -};
> 
> [Severity: Medium]
> Could this cause a userspace regression? The group has no attributes,
> so the existence of /sys/class/net/<iface>/wireless is the whole
> interface. A script that tests for it with something like
> "[ -d /sys/class/net/$IF/wireless ]" would quietly stop finding wireless
> interfaces, without any error.
> 
> This removal has been done and reverted once before. Commit 35b2a113cb02
> removed the directory. Commit 38c1a01cf10c, which the commit message
> cites, added it back because the removal "broke (at least) Fedora's
> networking scripts", and that fix was tagged for stable 3.6.
> 
> The commit message says:
> 
>   Last known user of this deprecated feature was Fedora, until 2012.
> 
> The 2012 commit said "at least", so it did not claim Fedora was the only
> user. I can't confirm from the tree whether any current tools or local
> scripts still do this check. raspi-config's list_wlan_interfaces is one
> example worth checking.

Good catch, this script actually still checks for the wireless directory.

> 
> There also seems to be no deprecation period and no Documentation/ABI
> entry for this directory. Would it make sense for the commit message to
> mention the earlier regression and revert? It could also point users to
> the replacements: the phy80211 symlink and DEVTYPE=wlan set in
> net/wireless/core.c, or nl80211.
> 
>> -
>> -static bool wireless_group_needed(struct net_device *ndev)
>> -{
>> -#if IS_ENABLED(CONFIG_CFG80211)
>> -	if (ndev->ieee80211_ptr)
>> -		return true;
>> -#endif
>> -#if IS_ENABLED(CONFIG_WIRELESS_EXT)
>> -	if (ndev->wireless_handlers)
>> -		return true;
>> -#endif
> 
> [Severity: Medium]
> What about netdevs that use only wireless extensions? For these, the
> wireless directory appears to be the only sign in sysfs that the device
> is wireless.
> 
> One example is ps3_gelic_wireless:
> 
> drivers/net/ethernet/toshiba/ps3_gelic_wireless.c:gelic_wl_setup_netdev_ops() {
>     ...
> 	netdev->wireless_handlers = &gelic_wl_wext_handler_def;
>     ...
> }
> 
> This driver never sets ieee80211_ptr. net/wireless/core.c adds the
> phy80211 symlink and SET_NETDEV_DEVTYPE(dev, &wiphy_type) only for
> cfg80211 wdevs, so this device gets neither.
> 
> After this patch, sysfs and uevents seem to give no way to tell that
> such a device is wireless. Only /proc/net/wireless or wext ioctls like
> SIOCGIWNAME would remain.
> 
> The ipw2x00 drivers also set wireless_handlers, but they get
> ieee80211_ptr through libipw, so they keep phy80211.
> 
> Commit 38c1a01cf10c covered this case on purpose: "Also do it for both
> drivers based on the old wireless extensions and cfg80211". Should the
> commit message discuss the wext-only case, since these devices have no
> sysfs replacement?
> 
>> -	return false;
>> -}
>> -
> 
> [ ... ]
> 
--
pw-bot: cr
