Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1D215F42;
	Mon, 20 Jul 2026 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510732; cv=none; b=TgqeZ0gJTCOYeooovh8tgrg7vj4rpSCbUM3OgrGtvi+2P83D1+adF8tSp8oE6zlEqSs6xnPa8UP8itTO15BtQmlhDt9/qMIS5ftQABraw/ZWrtDOxKBnvunPOloJfwNFfBXAS6u1z+NTin5bL+4FP23rsXCpLylCKgxU6AyXhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510732; c=relaxed/simple;
	bh=6+7F/NUZipP39RuwxK+wfw4W4GdOSPJJypNWhoTT/oM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B/vQc0kfJNkOCz6mJGmqbCztrSKTW6o/hPJNTLnYianxoBbXGnd9kX8obsYZZjtSVEOIoOE61xdSGSJwP+Frp4gYmHsPcMH1gQfNAHEwTUbw8c3cr3WWBI3IFX4M1nlo1mzBlIWXLPUuUBh+jEtZziSQp1hx2MWnoaqJLFRKCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h3N932p8PzKHMPK;
	Mon, 20 Jul 2026 09:24:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 071E840539;
	Mon, 20 Jul 2026 09:25:19 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCn2Fn9eF1q9cl1Bw--.35424S2;
	Mon, 20 Jul 2026 09:25:18 +0800 (CST)
Message-ID: <5d3b049b-f671-4773-a05f-39fd986d8489@huaweicloud.com>
Date: Mon, 20 Jul 2026 09:25:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] e1000e: Fix out-of-bounds MMIO access by validating
 BAR0 size
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260715035850.588070-1-pulehui@huaweicloud.com>
In-Reply-To: <20260715035850.588070-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn2Fn9eF1q9cl1Bw--.35424S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5Jr1rXrWrXrW7KFy7Awb_yoWrury8pa
	y3Ga45Cr4rXr17W3WxJr1UGFn8Aa1qyay5Cry7WwsY9F1UGw18Jr17tFW3Grs7Z34kAr9x
	KryUZ34Ikr4qkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Gentle ping~

Hi all, Is this commit looks proper?

On 2026/7/15 11:58, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a kernel panic caused by an out-of-bounds MMIO
> access in the e1000e driver.
> 
> [   82.868719][  T404] e1000e 0000:00:02.0: The NVM Checksum Is Not Valid
> [   82.872328][  T404] Unable to handle kernel paging request at virtual address ffff80008894e090
> [   83.085218][  T404] CPU: 2 UID: 0 PID: 404 Comm: bash Not tainted 7.2.0-rc2-g3f1f75536668 #1 PREEMPTLAZY
> [   83.129013][  T404] pc : e1000_get_cfg_done_82571+0x70/0x158
> [   83.140092][  T404] lr : e1000_get_cfg_done_82571+0x68/0x158
> [   83.151196][  T404] sp : ffff80008ac37410
> [   83.158922][  T404] x29: ffff80008ac37410 x28: ffff0000cd6a11b8 x27: ffff0000c58190d0
> [   83.173919][  T404] x26: ffff0000cd6a11b8 x25: ffff0000cd6a0bc0 x24: ffff0000cd6a0000
> [   83.189417][  T404] x23: 0000000000001010 x22: ffff0000cd6a11c0 x21: ffff0000cd6a11b8
> [   83.205195][  T404] x20: 0000000000000064 x19: ffff80008894e090 x18: 0000000000000000
> [   83.220545][  T404] x17: ffff800081c1a3f4 x16: ffff800081c19c10 x15: ffff800081e86510
> [   83.235764][  T404] x14: 0000000000000001 x13: 0000000000000001 x12: ffff60001bc8a8b3
> [   83.251301][  T404] x11: 1fffe0001bc8a8b2 x10: ffff60001bc8a8b2 x9 : ffff800081eae25c
> [   83.266705][  T404] x8 : 00009fffe437574e x7 : ffff0000de454593 x6 : 0000000000000001
> [   83.281919][  T404] x5 : ffff0000cf2b9640 x4 : 0000000000000000 x3 : dfff800000000000
> [   83.297317][  T404] x2 : 0000000000000007 x1 : ffff0000cd6a11c0 x0 : 0000000000000000
> [   83.312601][  T404] Call trace:
> [   83.318662][  T404]  e1000_get_cfg_done_82571+0x70/0x158 (P)
> [   83.329748][  T404]  e1000e_phy_hw_reset_generic+0x17c/0x1a8
> [   83.341541][  T404]  e1000_probe+0xbd8/0x1988
> [   83.350334][  T404]  local_pci_probe+0x84/0x130
> 
> Repetition steps:
> 1. Find PCI device which BAR0 size <= 4K. If it's:
>     Device Addr: 0000:00:02.0   BAR0 SIZE: 4K
>     Vendor/Device ID: 0x1af4 0x1004
> 2. Unbind the above PCI device
>     echo '0000:00:02.0' > /sys/bus/pci/devices/0000:00:02.0/driver/unbind
> 3. Set the above device to e1000e new_id
>     echo '1af4 1004' > /sys/bus/pci/drivers/e1000e/new_id
> 
> During e1000_probe(), the driver maps the device's BAR0 memory region.
> If the device has a 4K BAR0, ioremap() maps only 4K of space. Later in
> the probe process, when the NVM checksum validation fails, the driver
> attempts to perform a hardware reset and falls back to the err_eeprom
> cleanup path.
> 
> This cleanup path will trigger an OOB access kernel panic:
> e1000_phy_hw_reset
>    e1000e_phy_hw_reset_generic
>      e1000_get_cfg_done_82571
>        er32(EEMNGCTL)
>          readl(hw->hw_addr + EEMNGCTL); <-- EEMNGCTL(0x1010) > 4K, OOB access
> 
> Fix this by ensuring the MMIO length (pci_resource_len(pdev, 0)) is at
> least 64K (0x10000) before proceeding with ioremap(). The 64K minimum
> safely covers the maximum register offset accessed by the e1000e driver.
> 
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++++
>   drivers/net/ethernet/intel/e1000e/regs.h   | 3 +++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad..46e58e926f7b 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7450,6 +7450,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	mmio_len = pci_resource_len(pdev, 0);
>   
>   	err = -EIO;
> +	if (mmio_len < E1000_MMIO_LEN_MIN) {
> +		dev_err(&pdev->dev, "MMIO len is too small\n");
> +		goto err_ioremap;
> +	}
> +
>   	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
>   	if (!adapter->hw.hw_addr)
>   		goto err_ioremap;
> diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
> index 6c0cd8cab3ef..b63adeea1563 100644
> --- a/drivers/net/ethernet/intel/e1000e/regs.h
> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
> @@ -242,4 +242,7 @@
>   /* PHY registers */
>   #define I82579_DFT_CTRL	PHY_REG(769, 20)
>   
> +/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */
> +#define E1000_MMIO_LEN_MIN	0x10000
> +
>   #endif

