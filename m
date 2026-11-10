Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324184;
	b=FcQ9Tr6yfAYwCikhxYhOk/G3Cl/wBCJQ50i19j3GY/wyxGIagwB10BedK8RoiH4e15bq
	 lHWYU/OVVjwThmSkzbtyoHUHNviQOaPuQvTxTP35pGAir+nTlCyI2O7vIpOIykBLjZ3ec
	 b5WeKBCX9KDJ5EBin+7R2TqYALjojnzAk6vvwbdZ74+rbo2ndLNXPk3sO1uXBQY3qDvVa
	 0eIXu4fXvFEQliCKn6trSGsr9O6D7sIC99iqMufpqn2OdKz3a9H6zPlHpzxFWgjbWojYM
	 karsgDaqMZj+KEr6sZnx/07fhnhwlDPR5xNfeE/26O0TvD/3DuxQQEh9KSFYgmADa/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324184;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
	b=SSMHr+HbqmDoQHPNP2UANJJ46w0Rrq6DcoG+yiILGNutzXy2fYxho0+AQkMZVZoJXL92
	 g+92Pr4CBxdAcifSJ8PbWi5vr5z1RisReOrtlJ3dcLa1vgtP/nupQe9IhgJ77uEOdlUtX
	 Hs65iKNK6zkUeg/vIPaeCSCK2gCXFv9u7kbxIFRhkYn+aWUNfRzFZC1vBjRvKCLMhAX0o
	 LUDK3+/WyBiNOl39jYBO1iEFHHquydJda3yxbzlF16G6Oiu1hHV4aF1GrN/0l1OeHCiry
	 V4tRDLtJeY0ZfYSCh0Mzu65OeYc3zduF3dzqmbaZDbzqF6WI8S4gbZIDrmCOfmCxnLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHoT96Zt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cLXS281p;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A8606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482A8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHoT96Zt;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cLXS281p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794324183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
	b=BHoT96Zt2sFqQr0qcClSUO6tcJVWsE6nPwhwa6q+ySamNKF46fi80NgxVSreCWW/XLyOHt
	6AwM2UqUI5K7nGDvKhrVeqChCGt7e40vFH7mnhpD3uw9v5sbvzAJZm/vQlT/TFG/BfPe+v
	MHXWzrjZSw5H7tYrt05nFBzAaelxukI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Wxm02XEXOwKJNXcWGEI4rQ-1; Tue, 10 Nov 2026 10:23:01 -0500
X-MC-Unique: Wxm02XEXOwKJNXcWGEI4rQ-1
X-Mimecast-MFC-AGG-ID: Wxm02XEXOwKJNXcWGEI4rQ_1794324181
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2068950f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794324180; x=1794928980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
        b=cLXS281plYgoEL+8VFtZmzfwaS+rmDzAC++bJdEueZX0znLqXvBeyQMv8yDT4wdTyP
         4XhforwI/6wB04h1SmjOyGAULbQBzq/Pt7HHZXLWGccDCcEYdTTBiamfp6xC7qRdRS11
         j/RIMnD2bOhaLg/WxsQButfn24xwAIVkhPmWcpsldIPPuwUCD5kVMUphjZ+zmhh+4+Bg
         Fn3j3FQ5D7qMFIWOyQeAR0SfS2wKZAQvpYNvacTKEFZ1S9R4r7VD83/E9CHi4yG62XZC
         LIcGuaqLqD+vhYeVg2gxqxi8fynepettd4XyKaD/2PhrVigVfusyuPwAqxUQPTsuK51z
         474Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324180; x=1794928980;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
        b=HRKtQnI1oa+O63srZ27YjWcxoKLzYiQZjYUwaF83OkxAGmG5eC/eJ1WiWbh1W3N5uk
         eGMQfvGNVyte+Oee6UW4FjHQN0CCyJ5Mtn6Y5jcL0h2KlpfbbBTP2QG1XUiIWR/vRCT8
         2tdp4tgUd0Uop79e+0knM7dp1Wy+DamOPDf9dCU9+GmNButvt6F130s9I7icTJd37DUL
         IYunb/7GROwBbSXZ++rzckdMsOkrdSuzUNmMviXDq+oX0Kh+XZurezdH2vrEymL1Mpj8
         bpEmklKFwJFIqbnsNAUBvORoZc/Jh5Lmx0uIA+krrXZyxulK2BTHUSjL2CIU3mh602Y3
         m7kA==
X-Forwarded-Encrypted: i=1; AL+hErFmduepjRNkgRqvK4a95qjSHRakq6aqrUrpSwvIz0AQB6fjxmKnAhszHfdHlOQUj/1cUxnx3kI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IfHTY8rpLssNAbiUn149F1yzaTn48hVa3QQWvmTY5HChWdhjq
	vlCf8LE8Z+gsBjEGE52HUKiF+Zt6nAjNNk5j6/p2GZOUoufixBavri8krrIyL19AN/+E48oDzSU
	U+YtjF7K3iop7Yh8kn4fQwYiKfVP4NXghU+KQvQ4xsVSTBRvapi3P+6p+wQ==
X-Gm-Gg: AYBFou3KL0jc3t78s+DQveo5knQWRWnqmMTgsMU0MkptpFexTAL6TAtWy9WR9tkVtib
	aOaYv9+m8/fFwjUhoVA/57+R7rio3ZV8b071CuLgdru8/45C1FuChk/7AuzZN1rZRrNW3xelq/c
	xKyhlzvb4gZ+hV4oTC/ewirswU1iACWtftCzRy+VVuMKdSTCJNBP5U9W2cv2CWVuE/84zWCuhRe
	aPMAwtM9MMcwDDL22ErWSwxqLFrl4qYqjxkUdTTYCgC0c1+UD7vA7KfPhHlz3akfT4NUoN5wrKf
	11j91dipt79EubiMAOeCpe1oLU7Kid1ugJjYY33cK26yiPXSR2QaadiW8U9sJzxiCOvGMRbIs0q
	M7Bkb7xP+KSOWqbHRgeQAXPaH5zW8y/7mq60=
X-Received: by 2002:a05:600c:3b98:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ba02351506mr60403415e9.32.1794324180546;
        Tue, 10 Nov 2026 07:23:00 -0800 (PST)
X-Received: by 2002:a05:600c:3b98:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ba02351506mr60402605e9.32.1794324179979;
        Tue, 10 Nov 2026 07:22:59 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022fbf75sm58097845e9.0.2026.11.10.07.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:22:59 -0800 (PST)
Message-ID: <cf90b9bc-80a1-4905-8669-823ff80c575b@redhat.com>
Date: Tue, 10 Nov 2026 16:22:57 +0100
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
Subject: Re: [PATCH net 1/2] ice: dpll: serialize changes of the SyncE CGU
 registers
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>, Jakub Ramaseuski
 <jramaseu@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20261110094350.184185-1-ivecera@redhat.com>
 <20261110094350.184185-2-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261110094350.184185-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/26 10:43 AM, Ivan Vecera wrote:
> All E825C PFs share the CGU registers R10 and R11. On dual complex E825
> the second complex reaches the CGU of complex 0 through cgu_peer. RCLK pin
> callbacks read, modify and write these registers under dpll_lock and the
> pf->dplls.lock of their PF. ice_ptp_link_change() rewrites R10 under the
> pf->dplls.lock of its PF only, so a link change on one PF can write back
> a stale R10 and undo an RCLK pin change made by another PF.
> 
> Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
> around these sequences.
> 
> Tested on GNR-D with dual complex E825, with a 2 to 4 ms delay after the
> read of R10 in the link change path to widen the window. Toggling the
> RCLK pin of one port while another port of the same complex went down
> and up 143 times lost 120 of 86814 updates of the mux in R10 without
> this patch, and none of 76992 with it.
> 
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_adapter.c |  2 ++
>   drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
>   drivers/net/ethernet/intel/ice/ice_dpll.c    | 11 ++++++-----
>   drivers/net/ethernet/intel/ice/ice_dpll.h    |  4 ++++
>   drivers/net/ethernet/intel/ice/ice_ptp.c     |  2 ++
>   drivers/net/ethernet/intel/ice/ice_tspll.c   |  4 ++--
>   6 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index 536923b6ae979d..aa2d8addae5bef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -72,6 +72,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
>   	spin_lock_init(&adapter->txq_ctx_lock);
>   	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>   		mutex_init(&adapter->cpi_phy_lock[i]);
> +	mutex_init(&adapter->cgu_synce_lock);
>   	refcount_set(&adapter->refcount, 1);
>   
>   	spin_lock_init(&adapter->ports.lock);
> @@ -85,6 +86,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
>   	WARN_ON(!list_empty(&adapter->ports.list));
>   	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>   		mutex_destroy(&adapter->cpi_phy_lock[i]);
> +	mutex_destroy(&adapter->cgu_synce_lock);
>   
>   	cleanup_srcu_struct(&adapter->ports.srcu);
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index c61bd645e460de..fd5585005d91ba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -41,6 +41,8 @@ struct ice_port_list {
>    * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
>    * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
>    *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
> + * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
> + *                  which all PFs reach. Used on E825C devices.
>    * @ctrl_pf: Control PF of the adapter
>    * @ports: Ports list
>    * @index: 64-bit index cached for collision detection on 32bit systems
> @@ -53,6 +55,8 @@ struct ice_adapter {
>   	spinlock_t txq_ctx_lock;
>   	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
>   	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
> +	/* Serialize changes of the SyncE CGU registers (E825C only) */
> +	struct mutex cgu_synce_lock;
>   
>   	struct ice_pf *ctrl_pf;
>   	struct ice_port_list ports;
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index ade1fb3dd06743..5148e419f49a07 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2027,7 +2027,7 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
>    *
>    * DPLL subsystem callback. Set proper signals to recover clock from port.
>    *
> - * Context: Called under pf->dplls.lock
> + * Context: Called under pf->dplls.lock, acquires adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
> @@ -2035,14 +2035,15 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
>   static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
>   				       u32 port_num, enum ice_synce_clk output)
>   {
> +	struct ice_pf *pf = hw->back;
>   	int err;
>   
> +	mutex_lock(&pf->adapter->cgu_synce_lock);
>   	/* configure the mux to deliver proper signal to DPLL from the MUX */
>   	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
> -	if (err)
> -		return err;
> -
> -	err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
> +	if (!err)
> +		err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
> +	mutex_unlock(&pf->adapter->cgu_synce_lock);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index bce0bea9a664bc..3f9a993129acef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -158,6 +158,7 @@ struct ice_dpll {
>    *     txclk_notify_rwsem (read)
>    *       -> pf->dplls.lock
>    *         -> ctrl_pf->dplls.lock
> + *         -> adapter->cgu_synce_lock
>    *
>    *   - @lock serializes all DPLL state mutations on this PF. When the
>    *     controlling PF's lock must also be taken (e.g. updating the shared
> @@ -169,6 +170,9 @@ struct ice_dpll {
>    *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
>    *     standalone (not nested under any other lock) to drain in-flight
>    *     readers before pins and the TXC DPLL device are freed.
> + *   - adapter->cgu_synce_lock serializes changes of the CGU registers R10 and
> + *     R11. All E825C PFs reach one CGU, so @lock, which is per PF, does not
> + *     cover them.
>    */
>   struct ice_dplls {
>   	struct kthread_worker *kworker;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 7980eaf9ce2535..449819cf8c8791 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1368,7 +1368,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>   				break;
>   			}
>   
> +			mutex_lock(&pf->adapter->cgu_synce_lock);
>   			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
> +			mutex_unlock(&pf->adapter->cgu_synce_lock);
>   			if (active && err) {
>   				dev_err_once(ice_pf_to_dev(pf),
>   					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
> index 85bacb7c3a7903..b99e02cfe559bd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
> @@ -792,7 +792,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
>    *
>    * Set reference clock source and output clock selection.
>    *
> - * Context: Called under pf->dplls.lock
> + * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
> @@ -898,7 +898,7 @@ static int ice_tspll_get_div_e825c(u16 link_speed, unsigned int *divider)
>    *
>    * Set the correct CGU divider for RCLKA or RCLKB.
>    *
> - * Context: Called under pf->dplls.lock
> + * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
Reviewed-by: Petr Oros <poros@redhat.com>

