Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C442E414;
	Thu, 24 Sep 2026 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285238; cv=none; b=k8tR9kjiYdDWK8Bz7yu5CimehNN5+A2om+hRJfuQVZPxFs2QAh7k8Li60ZDbnNEg3xFNNR8KE+C8UCKkciJUJAPQuLc/BRW9Uv91TJxYI+HddVnAuE7Pq7W3BSt3YYMuFwqkb/hlt2ewevYxlPPi8JOOE2wH4VzlSDRzRGaZ/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285238; c=relaxed/simple;
	bh=WeSEsIdrN6td3owWuqmG3fnbCN0BRVTLIdJFtLyExCA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aC3wgBvJ8Bzq8tffJOSrmSBC+hp0MljddIDBbFjZZPdO0IHxVMou/HzjepGXk5McvMcaRVfF3QBVAhb8ZYd/Ih1P3I/oR4lIp60dAWW9OP6G3swL4U8D9gaviDcT7IePefdjVldihirujwmPZP46TkMgaC+KVdjBBAZ6QreGA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aXdsXiTg; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aXdsXiTg"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qy6-00A1u0-HL; Thu, 24 Sep 2026 23:27:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=t/jdVlLaiEn4bqSyNDSfDJ0wbOugkQLM4FXNsmpyMXI=; b=aXdsXiTg3E5IxDpiWMhg5Hw6Bl
	Md49H9PyqTVeSZgC86DQnYIHHYUUSR3sWZMxV6zds6MWEx509Qm0hNGAGLxRqu67bUJPMMlm9XNp6
	A4xWYF5pWUC6CfowqhdsZw10Tu/Z2qihJp5ltAv02jO64Iwe7msUglcO9QLP5fXXy8N18UaAH2VZp
	uj6REykTrXAFPwkTjPE3i2h4NvGy6HkwWam7tABEBIaNM4NPBA74+4VVtF2Tmvw7gmcM5DNx2c4mx
	BNAS+FFQqXJ2u5iA5rIQRnBTbS1rpVfdzDyuWXQpGxT7raHcP0B50M4WlhOPOlLSzQNkakaSV0tGa
	fVd8GvtQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qy1-0006Jl-4O; Thu, 24 Sep 2026 23:26:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qxt-006cN3-1W;
	Thu, 24 Sep 2026 23:26:49 +0200
Message-ID: <6c1516ca-4699-4d9b-af6e-c7762759d495@rbox.co>
Date: Thu, 24 Sep 2026 23:26:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
 <aqp7CV9DnfsG1GJc@sgarzare-redhat>
 <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
 <arT3jXoS7OaU6Tsc@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <arT3jXoS7OaU6Tsc@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 12:17, Stefano Garzarella wrote:
> On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
>> ...
>> I've addressed all your other comments for v2 and went through Ashiko's
>> reports (side effects of lockless peer_shutdown write, imperfect
>> no-transport TCP_LISTENER enforcement). I've decided to try the
>> eager-unassign approach. I think/hope this way we sidestep the lockless
>> writes and enforce the invariant without breaking the API, while fixing the
>> bugs.
>>
>> This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
>> have a go (too). Hope I'm not breaking any workflow. Let me know what you
>> think.
> 
> I think you can add RFC also on a v3 patch, just to make it clear you 
> are not sure it's ready to be merged.
> 
> That said, thanks for that :-) I'll take a look today or next week 
> because I'm off tomorrow.
> 
> I'm just worried it's becoming too big for net. Anyway, I'll comment 
> there.

Yeah, I get it. Would you rather have a single net.git patch[1] for the
original report + keep all the rest for net-next, or do the whole series as
is, but slowly at net-next?

[1]: Basically
https://lore.kernel.org/netdev/20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co/
+ your comments addressed + addressing one of Sashiko's comments, and
ignoring the transport-reset-surprise one

