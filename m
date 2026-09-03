Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BF4399E6;
	Thu,  3 Sep 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431276; cv=none; b=ayLkyWzIRdv+/t4AatL9Q7y7s4wfkZCVocfIY8wCqnV5czqu+HOGNd5MxxjWbgbCpbDn/aU8Wnog4D4u97sOczdHoFASskVGvosWkmNnBwHSLK7PQLrHapADRrIIv692CermwcjlQxe0NMDMX2G+C5FJNt/AR4erLupaYeGs76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431276; c=relaxed/simple;
	bh=xQcJuDFvFPBT6ZYRpZgPGU8Uad9koS4KrJdIrgeViB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPBvJ5SuXwb3AipbLioUhHZrjt36h6WH2oCW9pVN9ciLrE66CQJ3WBy+rfflMM73s6EeaenyAevZ9L1GH61xYhjE6ZZwYLDtJjEOYTzy+oCEZ0oIG5aGIjCPW8DUWNP+fTLbEoLWkaEOLBFihpyerR5obHoqUMSpsE6AxyglJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0sleX8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0sleX8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B71F000E9;
	Thu,  3 Sep 2026 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431263;
	bh=atJ2KXPXSgGiq2OqP7CMIUjSO8wmjaHoVZs8sAlmqBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L0sleX8b5Wj/WKStYZA6hK9/wQDat30zobX24QjYj83n4y0YfoclGIR2uC6AU7EWr
	 GfIKHI7LlqeAtyZPwuE5T2rYARl2SkP5tdg4pvqwGXKd6TYycldWoefRszGn92f6yu
	 v1adk2QSVTj+NBgRAWA7JcKijrOfRJ9xxsDRADDFwbDiVvM4Zg02Hj+cimlU3aQVzm
	 c7W++roFN1tZw2GjTQTmDMOTfo6fqZ1Rw9aCtr5WSTBR4ZpPA4bojM7EvnAHcQ3JXK
	 ptsQofWLY43QHngnq8H4oALiBPZqNe5/57vq8AsvViaEnXvWWGo8QfWOPDq4sI4RYk
	 Hw0UO0rCbisBQ==
From: Simon Horman <horms@kernel.org>
To: tactii@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
Date: Thu,  3 Sep 2026 11:27:30 +0100
Message-ID: <20260903102730.578872-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830232146.36948-2-tactii@gmail.com>
References: <20260830232146.36948-2-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=1
---
e1000e: add jumbo Rx CRC stripping
    
When the hardware is configured to not strip the FCS (CrcStripping=0),
the jumbo Rx path would deliver frames with the FCS still attached.
Follow the standard path's convention by stripping the FCS at EOP and
leaving it out of the byte count.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..599600ad695cd 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>  			}
>  		}
>  
> +		/* strip the Ethernet CRC; it may span fragments */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
> +		    !(netdev->features & NETIF_F_RXFCS))
> +			pskb_trim(skb, skb->len - 4);
> +
>  		/* Receive Checksum Offload */
>  		e1000_rx_checksum(adapter, staterr, skb);
>  
>  		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
>  
> -		/* probably a little skewed due to removing CRC */
>  		total_rx_bytes += skb->len;
> +		/* If configured to store CRC, keep the FCS bytes out of the
> +		 * total_rx_bytes counter
> +		 */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
> +		    (netdev->features & NETIF_F_RXFCS))
> +			total_rx_bytes -= 4;

[Severity: Medium]
Could these lockless evaluations of adapter->flags2 and netdev->features get
out of sync if userspace changes features via ethtool while a packet is being
processed?

If a concurrent change occurs between the first check and this second check,
it appears it could lead to an inconsistent state where a packet's payload is
incorrectly truncated by 4 bytes, or where the byte statistics are overcounted
or undercounted by 4 bytes.

>  		total_rx_packets++;
>  
>  		/* eth type trans needs skb->data to point to something */
