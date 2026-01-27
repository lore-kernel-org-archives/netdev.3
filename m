Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB31E520A;
	Tue, 27 Jan 2026 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500471; cv=none; b=NdWOFjiyw4T1kUuzNKmLMz1kOIvRJQlE8OnpOXGL6DgU8QyjJaWUirKmJWUhsZCivcMgLf68kI0HFfPIdg4M6uYUW210EnqjyhLXQwM5yryoEsvK+bVsB1HR50DbFg7AeRG60RRaRzkJEvTH80NVpyZ+q7QONR4vuTSesz0K9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500471; c=relaxed/simple;
	bh=qMTSBm+EL1++ek6f18p5cG5XR7YashfVLGasolSURxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fyU187nMDxEoe/PREBhQlyLCq8lEjDHgXHEQ5tmWIVALIo5C4hZWNpnjXzSC+qNYRNfIF0UAfsawJ7kjZIhN1Kptxm5nlrw9DOJrZXg8wXFWsr8LMS+SqiW2GImR70ls4sr4k1BCvg2rTEso63KE2nkOsmkJL1SSy2SqR6P4CLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0d2P48TxzJ467W;
	Tue, 27 Jan 2026 15:53:49 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 28B074056B;
	Tue, 27 Jan 2026 15:54:25 +0800 (CST)
Received: from [10.123.122.198] (10.123.122.198) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Jan 2026 10:54:24 +0300
Message-ID: <acb923ce-82f0-4a0a-bcfc-aadf00b746b6@huawei.com>
Date: Tue, 27 Jan 2026 10:54:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/3] ipvlan: Common code from v6/v4
 validator_event
To: Eric Dumazet <edumazet@google.com>
CC: Kuniyuki Iwashima <kuniyu@google.com>, Dmitry Skorodumov
	<dskr99@gmail.com>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang
	<shaw.leon@gmail.com>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
 <20260123170412.906280-3-skorodumov.dmitry@huawei.com>
 <CAAVpQUBGAitiYbXjGoU7ByaXuU9oYF3nfywu43susMHi8mSy8g@mail.gmail.com>
 <a4a16ead-a534-47e6-8468-58898350415c@huawei.com>
 <CANn89iLQ2tDcWq-aLe-FhQU2cX8txF5L9SewiB1ssJh+7ds46Q@mail.gmail.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <CANn89iLQ2tDcWq-aLe-FhQU2cX8txF5L9SewiB1ssJh+7ds46Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 1/27/2026 10:37 AM, Eric Dumazet wrote:
> On Tue, Jan 27, 2026 at 6:56 AM Dmitry Skorodumov
> <skorodumov.dmitry@huawei.com> wrote:
>> It even might be a good idea to replace wherever possible preprocessor
>> checks with runtime checks. Use
>> if (IS_ENABLED(CONFIG_IPV6)) { ... }
>>
>> instead of #if IS_ENABLED(CONFIG_IPV6) ... #endif
>>
>> --
>>
>> I'm ok with both approaches (though i tend to like runtime checks) - but
>> unsure what is a common practice in bpf-net
> 
> What you call runtime checks is in reality the same : C compiler is
> able to optimize constant boolean expressions

Should I fix patches to be something like

if (nblock == &ipvlan_addr4_vtor_notifier_block) {
} else if (IS_ENABLED(CONFIG_IPV6)) {
   ...
}

but still with __maybe_unused for ipvlan_addr6_vtor_notifier_block ?

I see that this __maybe_unused is used quite often in linux-kernel in 
similar way

Dmitry

