Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B9511E8C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883977; cv=none; b=Qnhbjpf3hZUXtwPDxZUeeTyFF9dWcik/nzcoi21u16lxhWDtv8EQ3m0/PHpF6O4EQ5pwpz74DIlJiAcOKMsBqPxBMC1Z1WCyvrLltbHshrbZ62fO70KSUsfrOqhyv3F9PvJ6cfoGRnyt1Ng3Kq2qK4f/zDPkH0k5XtuDqvVa8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883977; c=relaxed/simple;
	bh=YAG/p2uvViRw+vxyRrhGP803cSs/AcKDMK5dMaKMeyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvASgXJdx2Q5S8epXfK1FzWhy7Gf0oI4sblq7Z20ehKv24w3Qjh5q+W3SejOi9hHzfcb8rTKyW7w/q/CWul8c0NfEFEvskkaxVUFphTWglhaN1AyhNW6xQ15L2pgBK0NxahH4AW/cfY8sNQZZInqwRV8hEENaQj/Y88arlnjyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwGHcSSc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwGHcSSc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so57288015e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883961; x=1789488761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbKHtTY9KT87kFPLKh9dpqTp4nN3nypI6GpO1jaX+sE=;
        b=VwGHcSScWX6Kf1sqqNThyQskAlAJd1sqI9uWm+OAizhDMa2qJwyFMRINBP4+M5eUq+
         Rn58p02yPnUSVZ/566dAHB0GLXEYBvMuaQuQ3Jm/hG5J+BTqgklnrkgsc2aW821pbACQ
         syhv3w9g1kUhxpfZgqigzf4GgH/0miLuLFuHapOjYVKPErWc3KNH6T5qNqwYuSvcnd3S
         6sjwMiKGz20T+oSJBKSFzh4qYXhZ0FAplkdvZI6QhbvVNkijowbIrfbAdRYRxz6T1Gqz
         r45rWLZMF+j0Qdgd5el8GLv9y0H3c+OKgcPPLpCzanR16iNoh9LR3MuDAWwag+nA2ijm
         sl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883961; x=1789488761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbKHtTY9KT87kFPLKh9dpqTp4nN3nypI6GpO1jaX+sE=;
        b=by7al0jiGSq7nNfI4ylpScprD5cS0QB9WXH6SvwN3ekjQgkzJS+SCCE3PRcsVEuOwv
         UB9nMyKji0B+CDy7+Vs8UZTxQRVfyaVkVpPbTPVSO3+3Rl5JccuK4YlsyShS85gacULq
         c3hzejpgLW1Gt17T/Jrlt/m8GSYXyJepbMgFTfnEo+CBU+g4ZvBx138z7tGFlK6QO5qL
         cXEIj36qtuqba7GTQMm8aH2eVy6KR1CyINpj9SrRduNojqjoTjVF7i6CoPvk8vI0DVhB
         slXcnVQ43hhxw76YFOBkLdgkOC3PUTK4w3xcWt7mkzlMgVsMSJ2h3OvxI2UuJPopua09
         YgnQ==
X-Gm-Message-State: AFuF++keh5soGzSakirhmgvcndOKxqh5vGDNuBSgBTd+SsPbp0cbgc6d
	7zeuulgNUR5KoYqkIuYLghjbsAp0aSNj9BHSI77KsmcUG/ihaPcCR0JsKsiAgsxf8XY=
X-Gm-Gg: AYBFou3/BrE6YEgrv8N5u2Hblj3cmjmglRsykbMc9Qngqj1doIJxG7Ob0nYQRsIUl4e
	JzkH3Y/4Ab/was46F9TPP2oGKTTWegnZfZ99B5x0VozYBURntQXx2uJaxwd25p4oAtRYIkVPn58
	hQvgNyPYTVCalsiF0AzmyLubjhydGOEeEQ+blvGH3SbXIb26fTbax0wu28xxJAZpRNxor/SlDiA
	wRo6UO/LYVkkbY6whmSKLhIVNdPVjjHaBDCs9JwnFbyBDzLdwZO+gt7Ip89B4Z1zlK/GNVs/hJ3
	0iNVwiSwum0bzZRTAT6LnkV3gOkodTbkqKDP/c7xckuIU8j9e/+PIelkO03dYttObIsvWD/KOKf
	0OPZNdIxFhUZRHdgOsMIk8JCAbWMIOvKaRpmKe+4IKC+0SrpYMQvA0nO+51GiuOsgG+7f1Giy8p
	h9mo3u64h0WClXzWenzz7phBtbambL21RaKkiYEv7jnJIYT2HmU3pFSPslPf6Pa3jqHKp2HQ==
X-Received: by 2002:a05:600c:4712:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49cf8248cd3mr498749485e9.13.1788883960771;
        Tue, 08 Sep 2026 09:12:40 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm36433502f8f.18.2026.09.08.09.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 09:12:40 -0700 (PDT)
Message-ID: <e6cfe188-c4ce-4919-bb16-9c26175e111b@gmail.com>
Date: Tue, 8 Sep 2026 19:12:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] nfc: llcp: fix slab-out-of-bounds reads when
 logging service names
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
References: <20260905225211.596366-1-omermetekaya0@gmail.com>
 <20260906003917.627282-1-omermetekaya0@gmail.com>
 <20260908154152.GA40544@horms.kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <20260908154152.GA40544@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/8/26 18:41, Simon Horman wrote:
> On Sun, Sep 06, 2026 at 03:38:08AM +0300, Ömer Mete Kaya wrote:
>> nfc_llcp_wks_sap() and nfc_llcp_build_sdreq_tlv() pass non-null-
>> terminated strings to pr_debug() using the %s format specifier.
>> The buffers are allocated via kmemdup() or come from netlink
>> attributes and are not guaranteed to be null-terminated, causing
>> __dynamic_pr_debug() to read beyond the allocated region:
>>
>>   KASAN: slab-out-of-bounds Read in __dynamic_pr_debug
>>
>> Fix both call sites by using %.*s with the explicit length to limit
>> the output to the actual length of the string.
>>
> 
> As a patch for net, this needs a Fixes tag here
> (no blank line between it and other tags).

Sorry, I know that but I wasnt sure whether to add it since the bug
has been there since the function was introduced. I will add it in v4.
>> @@ -135,7 +135,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
>>  {
>>  	struct nfc_llcp_sdp_tlv *sdreq;
>>  
>> -	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
>> +	pr_debug("uri: %.*s, len: %zu\n", (int)uri_len, uri);
> 
> This does not compile because the trailing uri_len argument is now missing.

Sorry, I normally test-build before sending but this
one slipped through.

