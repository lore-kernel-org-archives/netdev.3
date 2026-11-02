Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625230;
	b=wnmbSpKHZZSw69wlTDvYTATMskHzJVE1sQx8XC7pClNwxqkf+Rk22YW2FanCI2atIYBR
	 ZsIFXC6lBG52m2xomnNXh1+uRi0SBLMM5KwX3ZDkGw1AQV18mxxCB9I6IN9oijIXCOvkF
	 FJOpmzxKnbcmfe6BaXRdleF71VkKs1QQOK2zQwnGlbJF/QNKdTE4Qf2mU9uvQsj4QBSkI
	 zMSgcfyiLvOYdW7FwmPzmXOf4dR4hcHnXB5Ye4t3HD3+0w0Az4JyoQL0D19Qx1thS3eR/
	 M7dKOdo96XdsV7NRsxONGdVPzmI2d4KWADoPmHtowMGjje5mUkedy/QsovsGCBAs6EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625230;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=41dy1SCR9ow3o2u84XXqAsUssaXOxzkkqJ2165MoOgg=;
	b=UEyXmRv4tmz8CE7VQwbugNlMbCS/1D1qZhfxyaTqdPsV+BmWc+5r3Ve56WvllkufqvAN
	 Rgm/rYp+XfJmrpAq6UJy0dM8OTq62xGUQucmUnKTQPoQEvp+ApvIznyFhQ4TBAm3dQLCi
	 xpV7Dix9xuLNK/fM6lKb3IL/Dnylb7ARuhFxxFdze+gqdwjOQegvUA6aDzUdHzON8hO87
	 JusCrxGF4pJzVciEDlLqJIF1+giuyzfE5u5kDl4mQzg6DxfvjiA9ZVKHMhl8hvLYmu1fZ
	 VYycjZPq4JqU41jP6bx1D6+qe2+GDblRRMu2T9ekxk7mE15B76k28Cz2cHR4JwX4Geg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=oXeBP6HL;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC9606A329;
	Mon,  2 Nov 2026 13:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EC9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=oXeBP6HL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=41dy1SCR9ow3o2u84XXqAsUssaXOxzkkqJ2165MoOgg=;
	b=oXeBP6HLpLLG5TH9BQ1tYP5ufiUrobOL1J9mcjjTkA7SZZRRj8eQu96WMv6VgK
	G/KeBgzvqPwCNFH1Rk7JLFGjEOUZjFr+3vyEQoQRjf954GDfYNOWLZ8VzIMt9x4V
	oNbsbsSmgnHJZmGcU9+QtyQWqYD3ZJMsf+OBiBRoiXNM4=
Message-ID: <84706e2d-5196-4e40-8bf5-122a0c54eada@126.com>
Date: Mon, 2 Nov 2026 21:12:16 +0800
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
Subject: Re: [PATCH net 0/2] devlink: do not dereference a missing param item
 or shared buffer
To: Simon Horman <horms@kernel.org>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261030033332.3685172-1-xiaolinkui@126.com>
 <20261102120504.GD257209@horms.kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <20261102120504.GD257209@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3nx4wjOhqr75HCg--.4115S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyUXr1UtryUKFWfXw4fKrg_yoW8Kry7pa
	y3tFn5tr1DJrW0vr4kZa18XFy0k3W8G345Kryrta4rZa9xCryftr43Kw4FvF1UCr4fW34U
	tw1av3WruF4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZtxDUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRQF22rojDRMHAAA31

Hi Simon,

thanks for the review.

On 2026/11/2 20:05, Simon Horman wrote:
> On Fri, Oct 30, 2026 at 11:33:30AM +0800, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> Two devlink helpers look an object up by id or index, warn when the
>> lookup fails, and then pass the NULL result to code that dereferences
>> it. A driver mistake (a param_id that was never registered, an sb_index
>> that was never registered or is unregistered twice) therefore costs an
>> oops instead of a warning.
>>
>>    1/2 param: devl_param_value_changed() hands the missing param item to
>>        devlink_param_notify() -> devlink_nl_param_fill(), whose first
>>        statement dereferences param_item->param.
>>
>>    2/2 sb: devl_sb_unregister() runs list_del() on the missing shared
>>        buffer; list is the first member of struct devlink_sb, so it
>>        reads and writes through address 0.
>>
>> In both cases every other user of the same lookup already returns right
>> after the warning, so the fixes just align the remaining callers; there
>> is no change of behavior beyond avoiding the dereference. The param side
>> follows the example Jiri set for devlink_param_unregister():
>>
>> Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/
>>
>> Both Fixes: tags point at the commits that introduced the unguarded
>> WARN_ON pattern; the current devl_() functions are pure renames of those
>> originals. No in-tree caller triggers either path today (the audit is
>> part of a defensive hardening pass), so both are aimed at stopping
>> out-of-tree drivers from turning a driver bug into an oops.
> 
> Thanks, both these fixes look good to me.
> 
> But I do wonder if the hardening aspect, from an in-tree pov,
> makes them net-next rather than net material.
> 
> I say that, because my understanding is that there is some pressure
> to only push critical bug fixes via net. This is because of the recent
> up-tick in bug fixes driven by AI-related activities.

Agreed -- net-next is open now, so I have just resent this as
[PATCH net-next v2 0/2]. Only the prefix and the base changed: the two 
hunks,
the Fixes: tags and the commit messages are the ones you reviewed, and the
Reviewed-by tags from v1 are kept. Neither patch carries a Cc: stable, so
there is nothing to drop with the new target.

Thanks,
Linkui

