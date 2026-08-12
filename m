Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D744780F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541881; cv=none; b=FbXXtHBde9BNWXrJTCTFOC8Bmu3MfAg7ioUPbqShwFqsfNup8MeOvTU2LYW1iyNM0Lwcfw3k5VpgN3lcJICstLkVzIwgA84vfL5MJHk/0c9DXV/UlcKTobxbHEVZUwjRNlQ2BnfhWBzH8XlGkxdvavWJwe7njW3mH3YiRzc7RWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541881; c=relaxed/simple;
	bh=11RMDYJUIYD+TsCck0t7sWQ7c6gaTHukqlFF9/6jO6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLAUhrhB8A+uQUYhiA07AWSfvIj2UZnohQzv3NDFsaZ7CEjl4TRjKoBZ5/tkbbhcIWFvt0JVkOmgv05yL+7wghRYn3wboksWstdoemWSO7H+aKC1NBX7PCuw2Gi1eJLrYd+D6d0gKTHFp8ZBCyDuzyEG+BxyaY2o4eR4kHhty7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9DOl1K1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9DOl1K1"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so183760566b.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786541868; x=1787146668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTDH3ObcVsD8b2AHboEh6kuXwjIYw3SkFUNxdVGoj5g=;
        b=N9DOl1K18yg0vkc9Oc2hHmc593PRxf5jjO6GHgj8xyQrR4weNZsdc425OSlZCz1doS
         ulPv4k6xqFP+Bp52iw3Lwc9OjoyFTC0qCAWxvOr4VOrDWQJavNthQ+hhGeZBItMeakCj
         I0Ceh3ARfrpJQHSzxuBP+XngSOvu/DIJ518FsSyAIk537NyUhlz9W6cm8rKTK8nPMhMM
         oaKujEfxU8ajEVl7Vij3zYXZIsscy/bucVijsdBn3AiXOl7ge69WNDKVF/SJR0w1jCRj
         NS/Svh8y024swt0to0+apdCptFtiJddjJ0kon/JekCnfUwCe0pdrw8cVN6VfvgcCrjvo
         dW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541868; x=1787146668;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTDH3ObcVsD8b2AHboEh6kuXwjIYw3SkFUNxdVGoj5g=;
        b=hzVL+7ZelFY8ztkvWr/mD5i9MuV5vc9XrU5nLn1cQYDx7FqrN77mXrsAbNXovKIBvy
         h7wlpncv4XsnGjddtkS4Jwv37G2kwfxL5wMXqAIp82qIDYWVAmb3CxPHZJbxPHoeP/Fc
         i7boJY6OXvH+lDYGPSJPCDqzoabl8CGwgjSn5Bl1t645c8K6DBRYkj+R7NcTNifK9zRC
         /m9QPguZ7jrCuRbtsXLJ26RxbpOEtIUfuQgBzC41koClf4AGeS4+D25u6/x+UGDgOOU4
         G1j6OOxa1WNK8uQEMjRCrbmRt/3Ju08Fne6tk7ATUSnSMKbTFPiRkdj47/c9ZzjscCNT
         1L6Q==
X-Forwarded-Encrypted: i=1; AHgh+RokLRo0hGQxy7B3R7m+DWRjTdBI9wv8sl47yrACo3Bpd9am+mvLkmlpsoNljGTbOymoSfas4MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCx1wqHtuORZIKk0AkYAdGSr30kqiv9quFMxvM2Tt1DkfHROzp
	m9VSf/Q5IHhfrVCtXnbD3ApEieCDBZvpfP0HbuVBIN2mZeQvuG9Oa8ma
X-Gm-Gg: AR+sD13OOUdc4trJTb+WQx5KyiWvV2w/8b+PIZb2ueD76R2nhdjScWtTN8tVenuTKmF
	pJzfZofdgKdrx/1HmgfyWiqGDwGtdRep9uF7x45wM4Bxmg/S+voBtoWHeu7FPUfklTwL2vcrotE
	0JtaJly3/fDET1bOqtzZTka1UWx+e+iPAQthOJl46PKVof/J23x49ttXlgtAgNDiglHQGDmbWQS
	OSzy0BycHTrr0q7TZuvVn7NB5BorO81P0DQF2Em0pjV4xOYRxT1ml8Wg1Q96fupzz6bZutv9uOY
	SMNerZz4mTkv2B1OZwPkp+2QOgNzops2vA7wniA3ZF5ToDmPd3zsitPQiGD9j+oROORIYhC+7sl
	GyDRiWC3gleZglFMhLGLMZhmlB/1fhqZx20ZG8BoxWrQYyfbV6/eHevBPWZReiSVrIDsoiWYtJg
	V8Mhe1wUx0rHESMHnWW19/US7BCLM2R4JIFQIWhSRHrR6FAT8DV7Sri9loNTsh5HKcxmjdNjemZ
	N8BjMIJIUOQwKiOZ3tY0WsyrWku8HZ67eLShMe9kcs0UBJqdBhqE+uCCWuJOz2X73xEt2tzxyhM
	j/s7AfrYW/0ig8n2
X-Received: by 2002:a17:907:1ca2:b0:c20:af9d:454a with SMTP id a640c23a62f3a-c20f3046604mr262300266b.16.1786541867962;
        Wed, 12 Aug 2026 06:37:47 -0700 (PDT)
Received: from [10.169.188.141] (82-132-212-67.dab.02.net. [82.132.212.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20f0d30dafsm92165866b.2.2026.08.12.06.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:37:47 -0700 (PDT)
Message-ID: <4f0685a2-562e-4b63-a6f8-9522ed5ff793@gmail.com>
Date: Wed, 12 Aug 2026 14:37:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: tcp: block standard payload injection
 into devmem skbs
To: Eric Dumazet <edumazet@google.com>, Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>, Florian Westphal <fw@strlen.de>,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260811195405.3979177-1-almasrymina@google.com>
 <20260811195405.3979177-2-almasrymina@google.com>
 <CANn89iJ=CAaqT94xGWgaxcZHhcMVQmy7=0B3fmW4mjKUz1DjoQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iJ=CAaqT94xGWgaxcZHhcMVQmy7=0B3fmW4mjKUz1DjoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/26 13:01, Eric Dumazet wrote:
> On Tue, Aug 11, 2026 at 9:54 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
>> page fragments to unreadable devmem skbs. Create a new segment instead.
>>
>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>> Cc: Pavel Begunkov <asml.silence@gmail.com>
>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>> ---
>>   net/ipv4/tcp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 455441f1b6949..186a36c698798 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>                  if (copy > msg_data_left(msg))
>>                          copy = msg_data_left(msg);
>>
>> +               if (zc != MSG_ZEROCOPY && unlikely(!skb_frags_readable(skb))) {
> 
> This seems wrong, as @binding could be NULL or not ?

I'd say it is *supposed* to be null as device memory without zero
copy doesn't make sense, but it looks like that can happen if there
is no NETIF_F_SG. How about rejecting it? It'd EFAULT somewhere in
skb_copy_to_page_nocache() anyway.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694..f403830af65f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1162,6 +1162,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
  					binding = NULL;
  					goto out_err;
  				}
+				if (zc != MSG_ZEROCOPY) {
+					err = -EOPNOTSUPP;
+					goto out_err;
+				}
  			}
  		}
  	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {


> Also testing the condition right after a fresh skb was allocated is
> adding unecessary cost.

FWIW, we can even remove all extra overhead with a new SKBFL flag and
checking it together with likes of skb_zcopy_pure(), but IMHO it's
better to be done on top if needed.

-- 
Pavel Begunkov

