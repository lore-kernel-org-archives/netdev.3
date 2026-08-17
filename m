Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087933A450A;
	Mon, 17 Aug 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009822; cv=none; b=qVROyMGEEtQuRzKN/7w6HaIQkc1+/YmQZ5yxOR+yrNXN1iEV0sApYgGtemWgjH4Rm+oOLzYuba6fPzdq3BQIEE+MOT3oqMmUCvYFVkjizOirLTUk8MGbmGFPSKNrWFEnRC3jLvGbnCia4hUu9qLslcl/7ZnHJmTB2N2a97whskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009822; c=relaxed/simple;
	bh=b5szdld2usDKCosW6MSByYCY0eNOtNo/yC0aE1LRayM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsrZJqPPQfZFL7xLjdkSRaIgQh4igovoelJmc/e1TIDaE03+lsTwt1B9EH7/HT1Naeav5ImMjo0C8g+NJLZtNwbfNwWhtcjwBtQXDsBqG7hjcFFRGiE5vWiafunZzGzEQCwmI8asTuh3MMKm9fe1Y6kdz2YRjpnL5p3MUhsQcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzau2Nk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzau2Nk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489451F000E9;
	Mon, 17 Aug 2026 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009820;
	bh=DrX8FWNXG0hB+4WSUZ5YU6ipE+s757XRIMHzQRErkgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zzau2Nk89ZzQBlwRgehlZBnkqnv0tls0Xwei6pFAmuFCjnmxL4wIjMoyLGGWOiHBn
	 m7DfIqxeFBlOBf3zQ0oDWZh69fL83UKk1qrJ5mBBRPkoq73IEKJ4DZ5scnryn6EiyT
	 0FFjU5OBN0u+kwbA41DBnq7CcndsZrQiZduVUBmT4hwxHNTlNregcWxnxPEqaooz7f
	 otKZfHRc17yZY9d/tJsJPlka+H7qCiox3/4AqBrJ9t79utnceTws5cdfAKrk1tP255
	 S+X+xoGjyKdDXsMHGXS1aOW6vJcZJr17aEaKOGQ7dH5a7axYc2dFCMpVyylctclBHN
	 ewxT9FkCPEj1A==
Date: Mon, 17 Aug 2026 16:36:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 10/11] bnge: add aRFS flow steering ndo support
Message-ID: <20260817163659.0d8a61b9@kernel.org>
In-Reply-To: <20260814011435.194631-11-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
	<20260814011435.194631-11-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 06:44:34 +0530 Vikas Gupta wrote:
> Introduce the ndo_rx_flow_steer callback (bnge_rx_flow_steer) to
> support aRFS.
> This callback creates an NTUPLE filter that steers matching packets
> to the appropriate RX queue. The implementation dissects flow keys
> from the SKB, creates an NTUPLE filter with the associated L2 filter,
> inserts it into the NTUPLE hash table, and schedules the sp_task
> workqueue via BNGE_RX_NTP_FLTR_SP_EVENT to program the filter
> in the firmware.
> Add bnge_cfg_ntp_filters() called from the periodic timer via sp_task
> to handle deferred filter programming and expiration via
> rps_may_expire_flow().

This one is not transient:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:3168:17: warning: result of comparison of constant 18446744073709551615 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
 3168 |                 if (filter_id == BNGE_FLTR_ID_INVALID)
      |                     ~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~
