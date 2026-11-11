Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395014;
	b=03QSIm2j/UOn4ndPk632kc0pN7NQTgUA8txQ7T+lvojm1C2dY8+qG0RhC8SDkh1Lradp
	 gS57k7jV+/PUZJRMPIXN57kloVyBdHQsOSr7wipv3SALvKvDY5K/CGlH4vqLj5ajdWWL9
	 Odt6Y9Nia59AmTepgLIBcnGTqUVekjEwRS1TRoovETDleq2Nxp+AB04P6sn1113I8Sv+o
	 fSMLkWV4C/kjmXWSVKWwIpVXbZ4/AJz6oEiSSjJJHGZtfgFlShpK4LSS+UndA6kPkk5h7
	 M/dUfWr550TUojXoK/obM8cn7UV1lmr3N5tbhaZ7rF3oBDUrUjZ7lwoBFO55hTO47/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395014;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
	b=eqazE7+yJFWWuEl0TeOuIuTVaLuh/Jg6JxbqgLBXWxaBaryJqDLwTVI36oMar2fMkMbL
	 uRn6kUz0nefcc9A0BWgZIu6esm1mBxbg/PwYYNi0QSRNIc/o7MZ/XjYfzEPZhdez52N0q
	 XQVrFvLTNNCcokOUzGUI1bCyNLHlfae9CbXfQX4lCXne8qUTT9PwDOR9+smUxUPp1tB7I
	 gfoHFO1Wr33m+6e5Dw7yZWg9yy/ucBiO2F5/c9KOswojWeiXb3471fVqR0dqF1C22bru4
	 R+jnJmFNMdVowk13qjNOGUywuZPjSeMPktUfK7GPl/ThLKIhLO+2LTZhX3PD/3yPdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R++CgykO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5414606A32D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5414606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R++CgykO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794395012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
	b=R++CgykOmkLCZzl3pxT1f3l0DUrQemxACw8vhyb3ZkShL1cttrx7J8q2cec0mMpORqt3Zb
	TY5ZLj/40hzOr8Sa2dZwVwkIx0MekeQkkhtmSe5On70BSRby8IX+9oda7gtTHTU9OdJHEq
	UBakyKL6j2b7BSefCm7e1FrDV/0ZCi8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-N6vwd9lROFKYldtDPkqikQ-1; Wed,
 11 Nov 2026 06:03:27 -0500
X-MC-Unique: N6vwd9lROFKYldtDPkqikQ-1
X-Mimecast-MFC-AGG-ID: N6vwd9lROFKYldtDPkqikQ_1794395004
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A14B818002C8;
	Wed, 11 Nov 2026 11:03:24 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 621521956087;
	Wed, 11 Nov 2026 11:03:18 +0000 (UTC)
Message-ID: <230b9191-ed71-47b2-8e64-456b6c60b480@redhat.com>
Date: Wed, 11 Nov 2026 12:03:17 +0100
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
Subject: Re: [PATCH net-next 09/10] ice: dpll: update locking comments
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
References: <20261106121005.1327603-10-ivecera@redhat.com>
 <179433320858.994134.3648996641880038315@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320858.994134.3648996641880038315@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The locking note this patch adds to the struct ice_dplls kernel-
>    doc (drivers/net/ethernet/intel/ice/ice_dpll.h, lines 168-170) is…
> 
> --
> 
> ice: dpll: update locking comments
> 
> This commit updates the ice DPLL locking comments now that callbacks run
> under the DPLL core domain locks instead of dpll_lock. It also adds a note
> saying that callbacks of the external DPLL's pins run under that DPLL's
> domain, so only pf->dplls.lock serializes them with the rest of the
> driver.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> index 4ba76e2e2e0b0..39e041a30090d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> @@ -165,6 +165,9 @@ struct ice_dpll {
>>    *     tx_refclks usage map), acquire pf->dplls.lock first, then
>>    *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
>>    *     to avoid recursive locking.
>> + *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
>> + *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
>> + *     so only @lock serializes them with the callbacks of these DPLLs.
> 
> [Severity: Low]
> Could this note be clearer that TXC and TSPLL are not in the same core
> domain either?

[...]
> The new sentence is accurate per DPLL, and the first bullet still says
> @lock serializes all DPLL state mutations. Since this patch exists to
> document the domain-lock rules, though, would it make sense to say that
> TXC, TSPLL and the DSN-domain objects are each in their own domain?
Yes. v2 will say that the core serializes callbacks per (module, clock_id),
that the TXC DPLL, the TSPLL DPLL and the other objects of a PF have a
clock_id each, and that the SYNCE and TIME_REF pins of an external DPLL
are one more such case. @lock serializes all of them.

Thanks,
Ivan

