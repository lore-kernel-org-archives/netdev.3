Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE61E98EF
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427916; cv=none; b=sv8g9Z2HJG7pmH7Ge1bcletiUs3XRkjLjcierQtxFf+l1PBPks7AFxE9OZx7xCdYgvg6bcehp32+RHUEg/9eWsErwEx21vv6OHN5HpnjxjsIyE0J+d7Pm+PpEV3DaEIZx4L8uDaYrSJTtpIqbraBvYefoD02/OOaWs0PokR4hZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427916; c=relaxed/simple;
	bh=lI2mxNE9KnVCsl0teA51X5qx5kUoJhxl9QfZ4/JhFr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHrYn7rKrBD6/zK39Poyjol/OuJDZM56ATUjGiocZl0J0FQe1SUmRXQxgVxA5DggbFp+3SzyviPwcyEWpsghh9KuOm6VFMmMIWqc0WPb/SY/lawC0qV2ldUSx/DvRqDVVDpPghiNSUUKr9OznR2BRMi+zgLQfSvKEhwbBL08ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DCvhpAVG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DCvhpAVG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso16906485e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788427913; x=1789032713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YoJRVDKsxA+JZQB/DUL9Ib2BpXMsLJBJ11fKOwMq4g=;
        b=DCvhpAVGDLRLPpY8mcQsF9vKis843htQECInKdLB+q92oUwr8+UwC4X0kzBmf2Zjmn
         HsxpK7OvxR+ZCviQJJHw0XhrCKcBgGtpz+1fdOttH2a3C2FGxKLwjTyGXzXlzcqQnphY
         WRdqO4bSabUXnWwi34d3E6Evm7Qd7lecHKpN84zmjI4w5RBUnWxAfNacrV8MUiIicks3
         kIAhQQX5iDueTW/C/VfoDGKlgbyWpLto91kpHJuK52Sg+qR+CJyhv7vR67kt4PiNWPU7
         4jFntZf36Qfs3CsC/JZYzXPEIb7bF4N+bJ8xaskCY+ITp+CainrBV04etEaHfjMzGS4Z
         2VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427913; x=1789032713;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YoJRVDKsxA+JZQB/DUL9Ib2BpXMsLJBJ11fKOwMq4g=;
        b=dsVyk0G1sIz0DSOtC+bnPWcMQLey8qvN17SGxskDCRNEp7IqXxHY64VdrH7UGCLTjT
         +Mac5URTbf8Hmy38ayRQyLH+4UOZ0ceQoCKOTeq0tkkv8uFccK8xds/a0H8pF3CHGYkh
         owY58p3XlKu77lvzCCg9V5WhtwTnxrA9bb+c+US7wu7sKwoQQjyX9T2EEDRK+Yi/mDGy
         jvPbLKcXnPj4n/h2zS21ReyrfuOFrZb/61SKJ8Kkm1smAotw5TKNtcQxKJtMwwhII/xX
         v6iqIZ6usorjIgflwiHNm7E5NuZRt78ZxYw7deNrJmhdQ0CJUbOj+iMcd+czTXGFddEP
         68wQ==
X-Forwarded-Encrypted: i=1; AKwUvByT9MmtjC3E6zfcNbwhhk+VmZxMIJEJnM1KFZyfJicPBRU3ci7xIfymFJomlmhGqXcVnLVjCEw=@vger.kernel.org
X-Gm-Message-State: AFuF++mDVmC6vefrF/aJZr023u8Lt7mY6F/aqNJC523dQzEAwxZuBlmq
	qRS843rNeQTCoOcRjo6XYU4u/wLtvBmg3RSVrnbHqcJ5LX0ggZHDuY0uq0cpLU/BlGc=
X-Gm-Gg: AYBFou1CLUHyVV0Q6XhDSB51+nc024+CnrMMUNCkNBohcA/teUzUKNLG15kATUBDb4w
	7+kuh/uPOWoxsZ2I/vUal5l00MQK1uDBVjCXwB33pnwMVEOdK16OMS0dScUV9jul4NdvjA+tGg1
	aBbVv600SQkLJYBXg6gzyz8QtMufa6XynTaUap+ucS0G86tey5RPwlxo8+YAIy5uDnRzLRL+f55
	Lb8gM/+djBwSLuMpIbgFPEZIMVFWYMPnUKqKhIUDLwFmtCNdZX2MQxYXNN28IFW26O5o02gIlTE
	DCFixiBeyrRQ2vqz3OGt4+jQB0V8vDycMrG/J/taJ1qGEYXChfH9wXoxFHVx0et+oLbJ1TGlkYS
	Z4S5LLCk1XUqRLhUn2nxDDF5yy7e8PU9grg5UAa83cGRedR/x2A4kmM9Z0PUSNkDOAxgaW+jKCz
	9h86oW/P1+Nh9SVW7irF14U6Y14KUhOR+dozDxjpGXr9TBUqsCnCQ1E4wszKgCuWkzbpXXzur1u
	tB47wh6vkoVoqa+SnA=
X-Received: by 2002:a05:600c:4e8f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49ce57f5647mr162091905e9.1.1788427912710;
        Thu, 03 Sep 2026 02:31:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80020sm12835333f8f.10.2026.09.03.02.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:31:52 -0700 (PDT)
Message-ID: <80d9e50b-fdc6-4337-9adb-8db1bd194ce4@blackwall.org>
Date: Thu, 3 Sep 2026 12:31:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
 <30c405c0-d17b-4107-a4f4-d2595c661892@blackwall.org>
 <apk9eDWX069eRKCF@fedora>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <apk9eDWX069eRKCF@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 12:27, Hangbin Liu wrote:
> On Thu, Sep 03, 2026 at 11:18:32AM +0300, Nikolay Aleksandrov wrote:
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index 947d92a669b6..f3290aee50d1 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>>>    		}
>>>    	}
>>> -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
>>>    	netdev_compute_master_upper_features(bond->dev, true);
>>>    	bond_set_carrier(bond);
>>> @@ -2339,6 +2338,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>>>    	bond_xdp_set_features(bond_dev);
>>> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
>>> +
>>>    	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
>>>    		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
>>>    		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
>>>
>>> ---
>>> base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
>>> change-id: 20260807-bond_slave_cnt-88e78c5f0ab9
>>>
>>> Best regards,
>>
>> Thanks, looks good to me. One minor nit if there's another version - mention
>> also the WRITE_ONCE() in the commit message or better yet do it in a separate
>> commit that properly annotates slave_cnt everywhere.
> 
> The WRITE_ONCE() change is made by Eric's recent fix
> bc93419130bb ("net: bonding: annotate lockless writes with WRITE_ONCE()").
> 
> Do you mean add a comment for all the slave_cnt usage?
> 
> Thanks
> Hangbin

Oops, my tree was older, forgot to sync it, my bad.
All looks good.
