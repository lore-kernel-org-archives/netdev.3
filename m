Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42053090E1;
	Mon, 26 Jan 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466847; cv=none; b=i70aLnxD2qyF5ZpSekUQeGAjRdiJVjmxCHxqoHQeS5zXnzfhHsmCdF8545u3agr2IGjL2IVVDoZGgLsYhJAWpvZZ0qmdyD9mQ+JYf4Zrppbfgk4KkFv1nI/gKbI4ADYYVR8Fvl/ZbmnZY7hA7bsLURYfbjrSvLw7HWj3ViGtuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466847; c=relaxed/simple;
	bh=L7dQA3UvTttbEjCFBXQLBw8pAFE810plceodU74rFzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rwux+lBLMzI9U5GIt4q/PkkZawhPgWOm/kvBUDkxff00LS+RTwROsgvTd8wIqrIBG+2dVSaszKKu6oTi9trPufILrU6/O7zH2Cqn8MBXdgbmf+zUMNAGfiE7UWWOTYWis7+5os+732RRqqZLsr1Gks1E6T8y/zS+6yVkvbXnCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af744.dynamic.kabel-deutschland.de [95.90.247.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5FF8F4C44300B5;
	Mon, 26 Jan 2026 23:33:19 +0100 (CET)
Message-ID: <fcfc9a45-79a6-4483-81ad-0cad9d2ab13e@molgen.mpg.de>
Date: Mon, 26 Jan 2026 23:33:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-net PATCH v3] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
To: Brian Vazquez <brianvv@google.com>,
 Brian Vazquez <brianvv.kernel@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>,
 Li Li <boolli@google.com>, Anjali Singhai <anjali.singhai@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com, Brett Creeley <brett.creeley@amd.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260126215600.3387171-1-brianvv@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260126215600.3387171-1-brianvv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Brian,


Thank you for your patch.

Am 26.01.26 um 22:55 schrieb Brian Vazquez via Intel-wired-lan:
> The code uses the vidx for the IRQ name but that doesn't match ethtool
> reporting nor netdev naming, this makes it hard to tune the device and
> associate queues with IRQs. Sequentially requesting irqs starting from
> '0' makes the output consistent.
> 
> This commit changes the interrupt numbering but preserves the name
> format, maintaining ABI compatibility. Existing tools relying on the old
> numbering are already non-functional, as they lack a useful correlation
> to the interrupts.
> 
> Before:
> 
> ethtool -L eth1 tx 1 combined 3
> 
> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> /proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
> /proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
> /proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
> /proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3
> 
> ethtool -S eth1 | grep -v ': 0'
> NIC statistics:
>       tx_q-0_pkts: 1002
>       tx_q-1_pkts: 2679
>       tx_q-2_pkts: 1113
>       tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
>       rx_q-0_pkts: 1143
>       rx_q-1_pkts: 3172
>       rx_q-2_pkts: 1074
> 
> After:
> 
> ethtool -L eth1 tx 1 combined 3
> 
> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> 
> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> /proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
> /proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
> /proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
> /proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3
> 
> ethtool -S eth1 | grep -v ': 0'
> NIC statistics:
>       tx_q-0_pkts: 118
>       tx_q-1_pkts: 134
>       tx_q-2_pkts: 228
>       tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
>       rx_q-0_pkts: 111
>       rx_q-1_pkts: 366
>       rx_q-2_pkts: 120
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> V3: Add more context to the commit message
> V2: Add mising Fixes tag
> 
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index c2a1fe3c79ec..c1f8dfc570ce 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4093,7 +4093,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
>   			continue;
>   
>   		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
> -				 vec_name, vidx);
> +				 vec_name, vector);
>   
>   		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
>   				  name, q_vector);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
