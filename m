Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1C2BEC43;
	Thu,  5 Mar 2026 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753103; cv=none; b=QTrLux4fiWQpoKBsno0w7XSNm7SAmI66lAoPRnf3fqvafpqty23HNVpqtvEASuzfiLnjTuM5YFQICkz3Bwm+spid5xDS/uWS6MT5j2lHGNtDVmqzPxPNRIsqgMaFxG7+pC64B+CORSZmI9rSovkbyAkOMsvPVGU0I4ValW3IHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753103; c=relaxed/simple;
	bh=AsJ24H0f8pHgRySYAZXNR2rc3siZoxvlNR5Jhljv81g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOCPhyLz4m0SGfVScJfHZ2gy7RB+jwCZRjYaBWZcc37YCjf6mqTszYaLe0VYkE3aZUJjxIEMdi1IPhUwzWylV2KQhkdGKRSG2NvFBJ3c1sHEKI2mBRsHO2tUqDQ15f9hVpmNCJeO6tayrozShf1DpcPuyMS+Ej2ht/Da3AfXYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osuchow.ski; spf=pass smtp.mailfrom=osuchow.ski; dkim=pass (2048-bit key) header.d=osuchow.ski header.i=@osuchow.ski header.b=1521GWOu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuchow.ski header.i=@osuchow.ski header.b="1521GWOu"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fRlxb5VDsz9tw2;
	Fri,  6 Mar 2026 00:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuchow.ski; s=MBO0001;
	t=1772753091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4n/3gX5tT6grnjPd/iHuVFIto2l7J4ghswAolDmPUI=;
	b=1521GWOuCdJUty63LvspmR42qKiQCns7iVBph4sauxRH0p3fNp8x9be7tAklxme8fLvc/Y
	pPnYBzluyPGWBCw0nXEIV+31VtnW+3KpQOOrPeh5z1Lu6g/KfdfN+dJSK+092RHapLzcFs
	x4oSoWLnGGhY+qSP6cPshBKoPHcmNf0MsDdyCXGfggX9dw0MA9wupjZmcAkbAP8SZQDTz3
	bsmTDhEMejb8zMNsv7IycOL/y3n/Gsq+MICrv9L6Hwdnftu1cixJwhPmXJ0WEHtqMBB3Fg
	wrntJQIkz5a3KRzhngN051AnIVML/WUJ7dUtL8W5sbusEyNV2o4bfbQb//Nbhg==
Message-ID: <07f515d2-af41-46f7-9336-28b5ecf36d9b@osuchow.ski>
Date: Fri, 6 Mar 2026 00:24:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 3/8] ice: fix retry for AQ command 0x06EE
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 przemyslaw.kitszel@intel.com, scott.w.taylor@intel.com,
 stable@vger.kernel.org, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
 <20260303231155.2895065-4-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Dawid Osuchowski <linux@osuchow.ski>
In-Reply-To: <20260303231155.2895065-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2026 00:11, Tony Nguyen wrote:
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> 
> Executing ethtool -m can fail reporting a netlink I/O error while firmware
> link management holds the i2c bus used to communicate with the module.

Hey Tony,

Writing from my private email address given I was browsing the list [not 
only for Intel drivers ;)] out of curiosity in my spare time and found a 
typo I thought I had addressed when sending to iwl...

> 
> According to Intel(R) Ethernet Controller E810 Datasheet Rev 2.8 [1]
> Section 3.3.10.4 Read/Write SFF EEPROM (0x06EE)
> request should to be retried upon receiving EBUSY from firmware.

During internal review someone (I think it was Aleksandr) pointed out 
the following typo:

	s/should to be retried/should be retried

It seems I might have sent the version without this change present. 
Could I ask Kuba or whoever would pull this in to fix this typo in the 
final commit message that will land in netdev? :D

Thanks,
Dawid
