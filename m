Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FE3B42DD
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201846; cv=none; b=NITml4f9CkIIPPFxn8P85GtOJwiJwS7+bkhlDx0BbJIX/eTOG+s5bJjg1lw2XDVqKHdzJkQkXeCieDhI8I9efl4AQfbuGuWORH1dUGI2FdhSDipUSo+yiBaL3moYxaj886/BYenaY1uodFp7YVHcsBofKCRbTb+K1HkJLfiM2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201846; c=relaxed/simple;
	bh=haygrbUGZc/yuuLx+pcROb+Rr2PyaZWebOApPN6gcno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6J9c2FTU0oMe6oNv3jw0GdVZugZegyByQxKLUWWH8jliudK1xaU/9pMcVuwFZ2eqoA2n9PKnkpJHFFWKqNK8dPBTXPB6oxPgAcFyKcMquXWcHmL0pVSM/lWA0Z0SciecbH07ual8ghiSkVqrg06EsIuj3vjsLDUV2t+X8oIHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlfqY/SK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGHlgj7i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlfqY/SK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGHlgj7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
	b=FlfqY/SKdtJVrkhANBi4UXlojkp8gTj81iF5bZGnOPT3DwH3h+ebN43w2pdFXeFGl0esE6
	G3At9sfBxBGUHvn7CGNbnso7tVX3ZVgu6zMZdZ/0XNr17xvPZ4yJOvCogkjjijofAVuTru
	/qL76AybzRPhU/K0aVWms8MrKoBvHjo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-uI0bA4KSPxKdLb5Y0qSitA-1; Mon, 05 Oct 2026 08:04:02 -0400
X-MC-Unique: uI0bA4KSPxKdLb5Y0qSitA-1
X-Mimecast-MFC-AGG-ID: uI0bA4KSPxKdLb5Y0qSitA_1791201841
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso14389165e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791201841; x=1791806641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
        b=eGHlgj7iAGg8QoFPi3hL21AEBUaXj8j5UL8fR46PNU96K64Xc+kTajcDh3XTZVrUoS
         sK6+ozLvi3vPdK3N4vEl8Ri9x8272xNdyFXbv5cieiPvLBR8D/uGfxX5CbGe/racmyhV
         UZyJm469DX0Uvm8RHDrRu145dNUt66IgR2lxBYFPMwN5E4U/MZ5zj+3MAnbxBOq20Q96
         5ZaKoYTfJKDiVah6i8UYwh7RVxoAocKV/fbLziXKnKrenpi8+iXtHBYzZ4vbLgLhhx5x
         //Co8MS7xL8anUoGSINmKFVl6PBg46eu/6Of1jHJtFO+ITgAYqEfc9+RGrrN3JxqhYPN
         xeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201841; x=1791806641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhQoza2mV1Z+1STVDq8chd2IZUgXS0fGFoZOu7nkEJQ=;
        b=Xn5L4jFsp8gryGQoEZS5gZzKSB2aVw0v5IdUGEWUYfmBBk21JCGBOMu6mr6Ubazah+
         eBrQ4LE3z7GkP2NI/J93Ygmn9Etaw20qZ4TCXFhrQovXw7tdCWrYAohQq6S6MJMaNNS2
         lPgsbgYXNGr5NEQ94OLdqzd6XDpMGikQtYy5Yrnbrq7mktfWNsI/Yk6jivjk2/nv2Sol
         wi5dKUdMkHQ0tRjg8aFdEYyJYc1pIEOjyH2QS8r6/+dQGtIxr7Fv78xR0N0n/nNFx6Wx
         A4HaO3P14xAvT1XJV4/s91RvUvn/OgIuup/c5ujQtcza4TF2dGffKe7X5HkVjfQjWdfr
         09bw==
X-Forwarded-Encrypted: i=1; AKwUvBzbBK/zwabEA8IMWotJZZEIM+uMCuzNcbKkK9+muBt0/SRx6tnC63ufIW/AcXRI6/YK29VW3Kc=@vger.kernel.org
X-Gm-Message-State: AFuF++lxmpFsrPhq/8mpSUFpm+f8m78o0wkPWdoCIrd+U2npBlrjwAiA
	fVNWzEmWJVf8k2u6uMqgznKq6Fn8+MU+4wreOAc8k1HG5Pp2vHe4S6yH/uOVLM6G+rKZk1n0iCc
	Og/ENAxHVYTCGd62CviPHHrWbf36/clc6/nb3C93R4qY+IzkxN1kzCpGDJDJLyg5oRA==
X-Gm-Gg: AYBFou2mycXZ6wyKlAvqA+Wh1Sx6MXYvJQjYbGCI4PalvMN4LMaDwAROZg08uGxoeBO
	kdASXuyCJPrzDShWLBkjAg0Psw4/Qri+G7PyEuq8gXlPGg37y5AuZtqwgSqYk1g11MnSZTZteaC
	iQtoD5HlJvn4V+rYyVQHMzuoPb3Ne14/VdOtxCVp6SpJ7HHU0+kGCouTZ0Uvg+Swc8tSOPjmZvq
	llX3zFllpD59q113g6X3ggIZQSPikmkYgP8ayPeDf85qpNjMMkyFY7Qc1yxf1j7BCrbEvHAaz8F
	TyMvBRaLS/vohU/kelOhysN0cKil74nC2xs8WGvz4rIGF7791d4bQMgTcRwXKuPPn8D4US8OGQ=
	=
X-Received: by 2002:a05:600c:2192:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a027569390mr123921085e9.16.1791201841007;
        Mon, 05 Oct 2026 05:04:01 -0700 (PDT)
X-Received: by 2002:a05:600c:2192:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a027569390mr123920585e9.16.1791201840418;
        Mon, 05 Oct 2026 05:04:00 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm310240445e9.10.2026.10.05.05.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:03:55 -0700 (PDT)
Message-ID: <d6c9d9f1-e693-427f-8151-d7a771c63ab2@redhat.com>
Date: Mon, 5 Oct 2026 14:03:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when
 ice_vsi_open() fails
To: Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@osuosl.org,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-4-poros@redhat.com>
 <1465AD22-8132-4286-A2AF-ED94E64E12C8@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <1465AD22-8132-4286-A2AF-ED94E64E12C8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/3/26 11:54, Ivan Vecera wrote:
> On October 2, 2026 3:07:45 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote:
>> ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and
>> enables them in hardware. If anything after it fails in ice_vsi_open(),
>> for example requesting the MSI-X vectors, the error path only frees the
>> ring memory and leaves the queues configured. Every following open then
>> fails to add the same queues again and the netdev can not be brought up
>> until the driver is reloaded:
>>
>>   ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
>>   ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x0002
>>
>> Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
>> The ice_up_complete() failure path already does it through ice_down(),
>> so let it skip the new step.
>>
>> There is no i40e counterpart of this fix, i40e does not add its Tx
>> queues through the admin queue. It was found while verifying the
>> previous patch. With the IRQ unwind fixed the warnings were gone, but
>> the netdev still could not be opened again after the forced
>> request_irq failure.
>>
>> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
>> Assisted-by: LLM
> Which one?
It was Claude Code with Claude Fable 5.1

Thanks for the review.

Petr
>
> Otherwise...
>
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
>
>
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>> drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d246cde36ae726..e62a8f544345a3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -7561,13 +7561,13 @@ int ice_vsi_open(struct ice_vsi *vsi)
>>
>> 	err = ice_vsi_cfg_lan(vsi);
>> 	if (err)
>> -		goto err_setup_rx;
>> +		goto err_stop_tx;
>>
>> 	snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
>> 		 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
>> 	err = ice_vsi_req_irq_msix(vsi, int_name);
>> 	if (err)
>> -		goto err_setup_rx;
>> +		goto err_stop_tx;
>>
>> 	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
>> 		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
>> @@ -7593,8 +7593,14 @@ int ice_vsi_open(struct ice_vsi *vsi)
>>
>> err_up_complete:
>> 	ice_down(vsi);
>> +	ice_vsi_free_irq(vsi);
>> +	goto err_setup_rx;
>> err_set_qs:
>> 	ice_vsi_free_irq(vsi);
>> +err_stop_tx:
>> +	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
>> +	if (vsi->xdp_rings)
>> +		ice_vsi_stop_xdp_tx_rings(vsi);
>> err_setup_rx:
>> 	ice_vsi_free_rx_rings(vsi);
>> err_setup_tx:

