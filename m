Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FC4EE862
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891188; cv=none; b=sg1phgAlzWbUL2z3Sz3OaVn6DnQXbLpCAja1/6usjwgEcKajMYj3M4Y0ODRRsfAfwcx6+fy0W0fUKeqyxqoPG0RV2K7u7d092wjX8bsYkxZT4QnBwRElf1yLS0bkMQCTUXN8Ss1Px5kajnu6Dsd6fhk4UqtmulNYV/j2cMuzB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891188; c=relaxed/simple;
	bh=Dyt5vMpr0stZOUUiRBwCWhlSpsziyIQGipCkD2GiSEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fakYzHL1cXl/0gn6rjx5zswUO93BU7iSIghY9aB5svXrcITxmDzgpo2m3VF1bDQR7+yU9iitnmB/o0duC/xBee4iOdAQJCw4kWCXoBQiY4HicMueajtZEStwaQs8fOV5DgU2TTEBO3ZxVl25w0UnQqKksAPMkRMHHy9Lokn2QR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwsGlsai; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahk/3uNF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwsGlsai";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahk/3uNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791891185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJZS7SNjtTyCzYl0fCzkLKDPQ9VWav3NaJT+Z7d7V7w=;
	b=hwsGlsait2xAMV7zu+26hqpL8zkZBANJDcyJ3NfiBiu5qVbS7CZw7YQF6WlVeNXoBgRwLU
	AaqKRJdYkdg5UdAGW5c1g4z7XUElYUV6GfV/APRppNZuFOy86Vln7nBhLMeAkpAtACXTfR
	i8yRrlp8LuqRRj1AHoUefpQW4koJj0k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-vVqGAKoKPia90RpSUZvCug-1; Tue, 13 Oct 2026 11:33:04 +0000
X-MC-Unique: vVqGAKoKPia90RpSUZvCug-1
X-Mimecast-MFC-AGG-ID: vVqGAKoKPia90RpSUZvCug_1791891183
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a028616bebso19853795e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791891183; x=1792495983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJZS7SNjtTyCzYl0fCzkLKDPQ9VWav3NaJT+Z7d7V7w=;
        b=ahk/3uNF9u3E0JJi2UXIlgtCAE1uPc+yqbKm0TfXlKW4BjodHwHFGpQC3+Hl7e7E/k
         ZYJlacamLHMFxfiF2FHvtyuZjeKNBJke0jnWER3gYRHjwIFnCl1jOe6KkdxD72vY2cg9
         N/6D23V9NCESfyTZz9ad9FSwC+S7gNfuNQ1J0c8xO1a73mfNNvWSgoMQIlykaXlHYn/C
         rYl4lqdUVOv0BKxSR6q1CERNkbo7QV3LoMR8o+7U5+vElWqldLnV59evV9zSgqNnYqzH
         b0Mr/I1E8p+pehIjMrKQuoDh0hpkCCHFLpEwwThAqH1xJq+DvxxEmYoDJGzwq49TzpC1
         M/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791891183; x=1792495983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJZS7SNjtTyCzYl0fCzkLKDPQ9VWav3NaJT+Z7d7V7w=;
        b=Wk9I9vV6EfGGe+4gpBA4RQGHPEwlcFpYCZMgC78Q8zRi2H4GupDk17M7wuzrTA2X+F
         +ZxO4dgHm5GJKzJUlK79smaeR/tRn2d2m++dhOX792i5HxdrxQhXhfCh2P0Fd9XN5bUN
         9ZvoLpm9mZBqG4H2IKSk78GVE8QhRVwi3BLy0Z11KNBolRsXaIBKW2AoSYo598uU+Ne+
         /5c/sDNLk7ogCib+qFdiEECGqGgZAlbepMDWeMHq4CEFyLwLcPmBa6fBwwoY4+J14BPq
         Sdh/wCQ9yZdRoxWXIBx87+n89rT7nmSUXcnrktSTVFqo0CQoCl7kYJzSb6771FK8ySWo
         nDEg==
X-Forwarded-Encrypted: i=1; AKwUvBxfm2AURbhZpl+V1tjUc9c2vku9NxHU4xMYnBdLMG9Mw4tduAlL7tmIJOowDiRTwccaPpKmn7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+q+zSuVETP/8tI/tpb8HFhf/Y6LPXqi2ndI0SwQUmgNh1kGri
	4SPqd3RmKj6r14J4byPL5e5JEbrF2h3PFq9mpBRAk/cqjiIJP2oOhTCYjtRW5aHSmB8F+wmaE9A
	Ln/CgXya+1jP4boD1u6fTp/sePDGvIPGr92bQULNO/mRdf8k5UksYW9kQmQ==
X-Gm-Gg: AYBFou1VKrQW9PYlP3rW8oKDx3eyjQ6Bs+P/J7096Io6Svpi7RjOtX9McT4FXv9zFMB
	g7qNiOA6RNc/eFac6MfPoUA6lCDfAHvhJTRUAGQiW7CrkOu8XRScarFiV5Xj/OeGZyslfTNyxa9
	uaCRbx4qchbOK5OLlbyIx873Kv2MxjyrpME2VBaFm6ltW/jm1E60vITY1ISz2akmT3OA1RUIHPy
	KpEX90hNOWibVPItxZ3c5BcpGZzDO+3venx8qS1RRC1qooLHrX4ZXa4HtNiKMJg7i3RXnrsBWju
	le5AY1dQSzpQcrCojjDXR4B6IWTLo7n63ITMrSkThP1ab1/S09MwPVRBQ621CzrdygCF3FT11lE
	icf9jcO+VMV2DEFUzQ0kv+DXZWoGrBaK0ZD5XyYEcdmEzPvjHfRNjqdS7sI+7R6AdUnchwtVflQ
	==
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr221725445e9.12.1791891183034;
        Tue, 13 Oct 2026 04:33:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr221724855e9.12.1791891182594;
        Tue, 13 Oct 2026 04:33:02 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f318c31sm133053675e9.3.2026.10.13.04.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 04:33:02 -0700 (PDT)
Message-ID: <4758dc6b-001c-4106-9258-f7d902fb01c7@redhat.com>
Date: Tue, 13 Oct 2026 13:33:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] net/mlx5: Lag, reset vport speed on MPESW teardown
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 Maher Sanalla <msanalla@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>
References: <20261006112415.259157-1-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006112415.259157-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 13:24, Tariq Toukan wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> mlx5_lag_disable_mpesw() never called mlx5_lag_reset_vports_speed(),
> unlike regular LAG teardown in mlx5_do_bond(), leaving stale cached and
> FW-configured speeds after MPESW is torn down.
> 
> Call it from mlx5_lag_disable_mpesw() as well, so the reset is paired
> with mlx5_lag_set_vports_agg_speed() on the MPESW path too.
> 
> Fixes: 50f1d188c580 ("net/mlx5: Propagate LAG effective max_tx_speed to vports")
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
The AI reported feedback looks like a pre-existing problem with
mlx5_lag_reset_vports_speed(), but AFAICS it makes also the fix
(partially) ineffective. I think this late in the cycle it's
preferable to avoid partial fixes.

/P

