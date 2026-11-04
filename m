Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801620;
	b=yw657k96kVKqG8Gv5lyI8e/CXH5H9129lb91cemDSWeDnb+lbvhtsAOV/CHQRnv9s58d
	 ayuNtHh3PRmA0NKU+J1BBgSWuyQfaKx5HRCJaupyR9Bdd5ddYX3rOFN5m4o5mstPceOsv
	 Bed4E/tCVk1kNUIQtrShj/nHG2EdyQumXo53SUhQRSNJDnqrapIav8RlsvZMGEmmH6nJo
	 RUfSFvGY78ue4EWpu+k+Qxv758Leml8EVy2INh0gfdidZW/pkVfHhTr12ZLn0rLL770Jn
	 jnwOelu6ipP+v9i/fxWe9apCsssf+6CF3pqVH06ncNCJsLT/uqsACLwlGgO26CkOQAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801620;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=C39tlu6xlshMWq2hwsMtOj8GLZZ3XOveWxHL0ZGLUl8=;
	b=LoCWpJsv+Z6BynNZLPR7FQALF4gazS7N+Jgwlfy+9g+Wc822oWJ8DntbKj2sWSzZgFJ9
	 xhCdBG79DOGcWuDRNJoGgUxBcsegQQG6RbVDpklchfbn4q9k0DzXzgQhwM0a62P+gHpzg
	 OUxhX/s2pkj0ea77qRbVpVwp6iyAAqPAx+PWf0IUmb8PJ1HPzYiCsBaFmyvnP2LSsNGmv
	 NiEtgRzmOHcHokZ4bJ1WxgjdfIMuWrOaF8K330mQ93qXTqlz59mD36fSIzBiC5li9Y6oT
	 dzDqVNouq9VzFNtBHHZLlpf7DpDbmzxfdrmEfON1Q0ca5mfITDQq9vbmh2yM2omG4Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Evfek09f;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mmqt+Q1j;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5A606D83D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE5A606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Evfek09f;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mmqt+Q1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793801619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C39tlu6xlshMWq2hwsMtOj8GLZZ3XOveWxHL0ZGLUl8=;
	b=Evfek09fxHUgg+q/tq4fvPAzJbHTYMQzd/yTceZKyIUBs0IljbGCq26EijJ4nCMUFe9Hc0
	PaD8M9BQs4jFqElqKWuCwwN79TekM183O0cMpZUU4djmxXz2izt+CZrx4TNwPTDZjx9Vrq
	6dFbKyDbYBJ9bmYM5tce8wgGIgqhups=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-14pKC1oKMVOsfiAwsY9DNQ-1; Wed, 04 Nov 2026 09:13:38 -0500
X-MC-Unique: 14pKC1oKMVOsfiAwsY9DNQ-1
X-Mimecast-MFC-AGG-ID: 14pKC1oKMVOsfiAwsY9DNQ_1793801617
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c430f0f01so694022f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793801617; x=1794406417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C39tlu6xlshMWq2hwsMtOj8GLZZ3XOveWxHL0ZGLUl8=;
        b=mmqt+Q1jLBJ5qfdX9Trw0Nt9nJEV2+9qd3k9y4/cbx+4mJlCsizDVidStqFpBHHdmv
         ZOhfM1LLFqA+wFzCyrlsE4MdyHYwBVVLrXrxbtOm28xzqn+oe/G3gytRxO6ql8cGL68m
         lvKUBEHIyO8vhWQjF/cnG2ChO4jATV0cLpbF5Gu33rwi1Fo8B/O+RaNXru+YJm6fkgcm
         WYqG0RGbNz4VoszIVQKkZA9RMejtfLHb8Y7EBEApw2eC5ZTuId8BO/JwKD8dy5NO+7OV
         3QdMSwAb6ZEkxZd4+BNcg+llu4p+hVBSfT+V1xUJydBLPOblgixaVyyvCPbLKSUSE+8V
         zesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801617; x=1794406417;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C39tlu6xlshMWq2hwsMtOj8GLZZ3XOveWxHL0ZGLUl8=;
        b=b2cee1ubPVFYoqY3+B1e9YhK6Hn3LkjMZEckQPYJA2qi3w09yeg9fz0y2n91dZy4Mr
         xoBfk1bVstgqBTqwWthPZdwmVj7gP62YfTikEHcx9E+G7OP72cV2nFxUn9dDxTv5bvIx
         iwSScdOe7GRehg6ehcXO5rrV1s5ee+UOvIKWn/PYevFZfvg7hNojFO0i9mYwA3pehgOQ
         hMBfwG1hjlYK1JeQnjeyG+Q/I103BWwrOyg2Q3iijXy4UgYtwSTEvLvajLvQ2NxAldC7
         g813IM/llVGW09Z/tZ7UbSxwky606z76F6s/2P+nTp18EkHPBcnNC1r7mymzrZqEzoJU
         oPgg==
X-Forwarded-Encrypted: i=1; AKwUvBxwaf9W1VHRXGzAF4YN8oOq4qQCsG59OoqP5nRQ5QqKbbxyAfFQXVAi4xPFAZKJySaOFX+/UPk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b1JwBi4IwpcLcFdPhmH0FrarmHLlag5oobIDuCNpnk0FQbgFE
	oNhmKWZI3NUSTlRmNRwFtyJS43ZiFVrY8E41ioqGuYZUgvuLpf8przPwA7rA+4E65zvLFIQlmc5
	wGtwovkK/E28H58k3UokmhJTaRJR6gX1o19d3/HesT88T2D5efRJAndrBwQ==
X-Gm-Gg: AYBFou3G1FuVlTgbRGZSl/gNfBlE9yeWkuO8xDmGvDNb/hB0SR6twevIk9RF9ZeXCZX
	ASNAeSZWWwl3h/jEB1Y5q+sgg5oY1ImOfixkOGdJzIRLppnhOp/A4XRyF16ZJ6nBHtlli38QxRg
	zRFlqrwfPtZbCYLoyLua026TbbG7i44yTtPvpFxFlgZ2vHR0ylmukRB1UB3CADEQ/9xX0MQQN+1
	yvs21z1v/lcnpn6OzI4D2jcBvBG+MUcJg+O8CjNgHFcZxW9bfzSsJ0lNX+D9ytuoH4hGV770064
	YY9FxhZn3o/o/L5lDJXvjOhyor93X52pp6bL/10UbsIEYK02uSh5o9arPErMieRkcc/jTUYKcDM
	/bpr91IDM6TSCpI6TC2xTQgN59tj59GcvVnwSAESCzkIWvyUR9KQ3Q405wP2ly76/T+eoUTIzVY
	zb1tOZW/8md8wOLhfUmDstcKU89aPj+mlW/GUasFr7DC0=
X-Received: by 2002:a05:6000:2313:b0:488:7d08:edbc with SMTP id ffacd0b85a97d-48e6e30ba6fmr37096695f8f.24.1793801616604;
        Wed, 04 Nov 2026 06:13:36 -0800 (PST)
X-Received: by 2002:a05:6000:2313:b0:488:7d08:edbc with SMTP id ffacd0b85a97d-48e6e30ba6fmr37096644f8f.24.1793801616114;
        Wed, 04 Nov 2026 06:13:36 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fe7189883sm4443181f8f.0.2026.11.04.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 06:13:35 -0800 (PST)
Message-ID: <b5187890-a0df-45c9-aeed-3b1fefba57ab@redhat.com>
Date: Wed, 4 Nov 2026 15:13:33 +0100
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
Subject: Re: [PATCH net v2] net/mlx5: macsec: free struct mlx5_fs_id after an
 RCU grace period
To: Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 "joasantonio108@gmail.com" <joasantonio108@gmail.com>,
 Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "leon@kernel.org" <leon@kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "sd@queasysnail.net" <sd@queasysnail.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <179313582625.87630.11382992904624255106@gmail.com>
 <e91e786d3bf20ed981ab2d214ae3358d137d597e.camel@nvidia.com>
 <94dfe8e7-5eaf-45be-94f5-7d2e2b38fdb2@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <94dfe8e7-5eaf-45be-94f5-7d2e2b38fdb2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/26 13:49, Tariq Toukan wrote:
> On 04/11/2026 13:20, Cosmin Ratiu wrote:
>> On Tue, 2026-10-27 at 18:17 -0300, Joas Antonio dos Santos wrote:
>>> macsec_fs_id_del() removes a struct mlx5_fs_id from its rhashtable
>>> with
>>> rhashtable_remove_fast() and then frees it with kfree() right away.
>>>
>>> The TX (SCI) table is read locklessly from the transmit path:
>>> mlx5e_macsec_handle_tx_skb() and mlx5e_macsec_tx_build_eseg() call
>>> mlx5_macsec_fs_get_fs_id_from_hashtable(), which does
>>> rhashtable_lookup() under rcu_read_lock() and then reads
>>> mlx5_fs_id->id. A transmit that looked the entry up just before it
>>> was
>>> removed reads freed memory.
>>>
>>> Before commit d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per
>>> MACsec
>>> device inside macsec steering") the SCI table held struct
>>> mlx5e_macsec_sa directly, and mlx5e_macsec_del_txsa() freed it with
>>> kfree_rcu_mightsleep(). That commit moved the table into macsec_fs.c
>>> with the new struct mlx5_fs_id, but frees it with a plain kfree().
>>>
>>> Add an rcu_head to struct mlx5_fs_id and free it with kfree_rcu().
>>>
>>> The same issue was flagged by the Sashiko AI review as a pre-existing
>>> problem while reviewing the HW-GRO for PSP series.
>>>
>>> Fixes: d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per MACsec
>>> device inside macsec steering")
>>> Link:
>>> https://lore.kernel.org/all/20260909065542.4B80D1F00ACA@smtp.kernel.org/
>>> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
>>> Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
>>> ---
>>> v2:
>>> - Drop the macsec.c hunk: the sc_xarray_element free was already
>>> fixed
>>>    by ad17ad50b8dc ("net: mlx5e: Fix use-after-free of the MACsec
>>> xarray
>>>    entry on RX SC deletion"). (Simon)
>>> - Embed an rcu_head and use kfree_rcu() instead of
>>>    kvfree_rcu_mightsleep(). (Simon)
>>> - Fixes: now points at the commit that introduced the kfree().
>>> - v1:
>>> https://lore.kernel.org/all/179285888829.90275.17386097105525068016@gmail.com/
>>>
>>> Testing: compile-tested only (arm64, W=1, CONFIG_MLX5_MACSEC=y, no
>>> new
>>> warnings). I do not have
>>> MACsec-capable ConnectX hardware, so this was not run on a device.
>>>
>>>   drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
>>> b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
>>> @@ -94,6 +94,7 @@ struct mlx5_fs_id {
>>>       refcount_t refcnt;
>>>       sci_t sci;
>>>       struct rhash_head hash;
>>> +    struct rcu_head rcu;
>>>   };
>>>
>>>   struct mlx5_macsec_device {
>>> @@ -684,7 +685,7 @@ static void macsec_fs_id_del(struct list_head
>>> *macsec_devices_list, u32 fs_id,
>>>
>>>       xa_erase(fs_id_xa, fs_id);
>>>
>>> -    kfree(fs_id_found);
>>> +    kfree_rcu(fs_id_found, rcu);
>>>
>>>       if (macsec_fs_is_macsec_device_empty(macsec_device)) {
>>>           list_del(&macsec_device->macsec_devices_list_entry);
>>> -- 
>>> 2.39.5
>>
>> Thank you for the fix, it looks good.
>>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Acked-by: Tariq Toukan <tariqt@nvidia.com>

While I have your attention, there is another mlx patch pending:

https://lore.kernel.org/all/20261028145805.54595-3-fourier.thomas@gmail.com/

/P

