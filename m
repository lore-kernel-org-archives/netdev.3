Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207891;
	b=x2JE5r5RplZ7nUcKUQtCmXpBEY+MiMe/eW9fBLR+HRKg7ozixjH0YtDCmUOUvSPojAve
	 vk39Nu5tDTj7HHkuZT4BwhKFvaOvcN/PxJjXPweHzJfAbDuqLOiY5JwzWsBH6qzsON4u+
	 KgGqLhPI9+HUgPokuRtUQwk7xprIekTuDpCQzzR+pyhwYFsiWe6wdoDXesOKzmNMRS1ym
	 97jHhvWF8071g+u6Hz1fC1JpiYEPP7+dzW7/GaRpq2STudc7S3+fSyYE+At2I7XM5Tfke
	 r21y8vpW1zz0daCuOmae90x/3tS67hmqEQ0JI7KEACrVd10hTjArhxYtQ8Jq7VCz7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MoqGoVuIDj85F9T+yZlnMdvqGFtpm28q4hBm37Nfu4I=;
	b=SESqtIpqKXWsEZS/K2MZDUXbMeauVF4qkWf8qQV46cwWybEaQ2L4RpDk3cN/Nv9vy1MY
	 HH2ojgXOvXTijNCX9XipOPKx9RJpyK/o12cy9THlKwtiRh6hehOaG15e0NxGthebfP9ez
	 4ubSB4geHGpGm2VPldjvxH+u+tg8iDKuqh4HlRRtnBkMnk47/QqNyUrV+EYhcArYPb0zJ
	 X+DshdY4p8S6qTG//6bAm9VKmQ4gS8iX73XTWnI8gE647VWmtKIPUUVudAMTyvPOuijhK
	 p6FxNVnkmTbyEnUK/4vz1DNiEr4nzfABciaURPECg8FgVb51fFApP9NHj193rOQZVzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYEa0qkR;
	arc=none smtp.remote-ip=74.125.224.130
Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C460A2603
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE4C460A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYEa0qkR
Received: by mail-yx2-f2.google.com with SMTP id 00721157ae682-8b0fa446a94so3214167b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207889; x=1793812689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoqGoVuIDj85F9T+yZlnMdvqGFtpm28q4hBm37Nfu4I=;
        b=lYEa0qkRIXVhCEs6QUd+QxTrzxUKTqAnoMPcLiSx/69Zo6ncYGnv5e/yS4sjbjRFe6
         iXFwJICl9SG1swyhVr/rRoJPuQcUITDUfumWBofEZtIvVKK3HicIXX8bv+fH6prhNFHh
         rSjrqNIsEjHcH8FhQUkT+Kknaf+h+ybRFHlJyTjxZBf0biiIlVC3Om+yD8WVjEddUSby
         u4OiDTAtf8/pXf0kGZdth5g6prsD6TPv3Tss83QEC9wBRd18X2QDE1eQ8fBQ5Gm5H/Vj
         UV5pnQspPVF9FgmbKZEkd/qgFMdTCY3PJI2HKBtzVzf2mc6UqVY9RLvaTCk/FeG0+RFr
         znog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207889; x=1793812689;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoqGoVuIDj85F9T+yZlnMdvqGFtpm28q4hBm37Nfu4I=;
        b=N5jKKRDeVH51/epOauQhcHNTqE45xjkZ/heC/3lKvHhJaUu5WwLFjH6b93SfcMdo7W
         W/rMDOLIi0d3HXGXznzy+QDkSVyk5MhT8U8hfxend7lS/rLWl1kQ50Dfw/dTW3MRQRVj
         AZWbJy7oLOw1Kfp+vvanxoAGoZCe2MmAbg5g5YkJsud3ye8UJZ8GQhaUDL9uNfRs6I68
         Hv8sMhPmIdRsHTcCMzEUmwWou5U6SD9dJH+PcAPilxqIvjHOzb6c+biFUqFdW/M5Hktr
         Kxl1786N9QlhNd63vvLXSzEteWEAXeqzcXEkkfVTA49B/Pr41sB3hU9nhdI/nFS/SNQz
         1hVw==
X-Forwarded-Encrypted: i=1; AKwUvBzszElO162BvWpzJjybW8X6PVpN3h1OaS0ciXc/otQEhr2aZf8dzpnSzXdAtfNwyphTbcr96KY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAn0JAsdf+tF3pc+xyuT7lBHXpaDlJA9QLcjCInAKfH5hHmy7B
	QgB8tQYbpxeaYJVkHnbpjh+3gYfB4vj9oxsgRRObN4eBzdFCCM7Rfpj3
X-Gm-Gg: AYBFou27MzhIst9WBxcnqe0PGV0/MvNcE6fSrbBRblHA1gLKntvH1/RIys3cdMuUmp8
	VIHnhB5nAY3Qa/3fWaYN9diAMDBKJBGGlqi+qbM+Eb2keaBgXafjS74Q61X1pkiIbb0zLY5BIkL
	WtzIX4PFOtynVlCf1mOYOyUyxPMYLyhvU6InRG5TA3mXd5bx5wZyJ+6BiVBqceQkirhaNoL7bNS
	FNGK8vsrn4YkRvQXuGt5MBxfvmuBQkI/iseLbnsSuuV5UQk2eR4XTkSUw2L94hp6XfZLcLiers9
	ddwopLu7i+2xv7Kuo6U7z0ETdcrvoWQeOnPbF01ZcxVfijt4sIr5T0n/1UhpaJl7tFE9FbBB3rC
	WgmHfIAFoviqK/ZI3uPSb9ihwyc624mmbfK0zsR73x4F8xiLzo8R+xE8ruzXG2Vj4dPXeKI/MI5
	n9iCyp4n37I6D/0Uuuo94TYobLyvWnt0SwyQLB81GIUyHr1SrVc0BiYun5fsSSJ/S4CtFHzyGTw
	BDvxOgrivryn/G00DUj96ldQreqwJP9iE+hOHdJkvGoIQQ3F6yt/JD8mJZbx1Twud3KcLqniuU0
	ke3gRc38ZW+wz0kQKxSOj+vRpMHtJGfYjFk=
X-Received: by 2002:a05:690c:6602:b0:8a4:d87f:8d52 with SMTP id 00721157ae682-8b1b59cdb34mr17759107b3.2.1793207889578;
        Wed, 28 Oct 2026 10:18:09 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e43d5c6sm31865247b3.2.2026.10.28.10.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:18:08 -0700 (PDT)
Message-ID: <0fe51c04-f399-448a-9975-0112cc573e40@gmail.com>
Date: Wed, 28 Oct 2026 13:18:07 -0400
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
Subject: Re: [PATCH RFC net-next v2 4/5] tls: send a KeyUpdate at the record
 limit and on request
To: Hannes Reinecke <hare@suse.de>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <20261028-keyupdate-rfc-v2-4-eb5143b4c487@gmail.com>
 <82963fe6-e908-4c1a-b963-ac1ab86f2bdc@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <82963fe6-e908-4c1a-b963-ac1ab86f2bdc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/28/26 10:23, Hannes Reinecke wrote:
> On 10/28/26 2:52 PM, Martin Belanger via B4 Relay wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> RFC 9846 section 5.5 requires a key update before the key reaches its
>> usage limit, 2^24.5 full-size records for AES-GCM. The limit counts
>> records, and only the record layer knows where records start and end.
>> Section 4.7.3 also requires a reply to a KeyUpdate with
>> update_requested, sent before the next Application Data record. Both
>> need a KeyUpdate at an exact position in the record stream.
>>
>> For a socket with a registered TX secret, send a KeyUpdate before the
>> next record when the key has protected 2^24 records, as GnuTLS does,
>> or when the peer asked for one. ChaCha20-Poly1305 has no record limit.
>> The KeyUpdate is sent as a handshake record, which closes the open data
>> record first. Pending encryptions are then completed, and only then is
>> the next key installed.
>>
>> Add TLS_TX_KEY_UPDATE to send a KeyUpdate now, optionally asking the
>> peer to update too. It can only bring a KeyUpdate forward: the record
>> limit is enforced either way. Following section 4.7.3, a new request
>> to the peer waits for the answer to the previous one, and no more than
>> 2^48-1 epochs are used.
>>
>> Assisted-by: LLM
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   Documentation/networking/tls.rst |  17 +++++
>>   include/net/tls.h                |   5 +-
>>   include/uapi/linux/tls.h         |   1 +
>>   net/tls/tls.h                    |   1 +
>>   net/tls/tls_keyupdate.c          |   5 ++
>>   net/tls/tls_main.c               |  38 +++++++++-
>>   net/tls/tls_sw.c                 | 150 +++++++++++++++++++++++++++++ 
>> +++++++++-
>>   7 files changed, 214 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/tls.rst b/Documentation/ 
>> networking/tls.rst
>> index 2e011bd1ce4a..69752a6d67df 100644
>> --- a/Documentation/networking/tls.rst
>> +++ b/Documentation/networking/tls.rst
>> @@ -326,6 +326,23 @@ direction is then left to the application again.
>>   The secrets cannot be read back.
>> +With a registered TX secret, the kernel sends a KeyUpdate before the key
>> +reaches its record limit (RFC 9846, section 5.5): after 2^24 records, 
>> except
>> +for ChaCha20-Poly1305, which has no limit. It also sends one before 
>> the next
>> +record when a received KeyUpdate asks for it. With a registered RX 
>> secret,
>> +the kernel processes a received KeyUpdate and does not pass the 
>> record to
>> +the application. A peer that sends more than 8 KeyUpdates in one 
>> second ends
>> +the connection.
>> +
>> +TLS_TX_KEY_UPDATE
>> +~~~~~~~~~~~~~~~~~
>> +
>> +TLS 1.3 only. Send a KeyUpdate now and install the next TX key. Needs a
>> +registered TX secret. The value is an ``int``: 0 to send a KeyUpdate, 
>> 1 to
>> +also ask the peer to update its key. Asking the peer needs a 
>> registered RX
>> +secret, and fails with ``EBUSY`` until the peer has answered the 
>> previous
>> +request.
>> +
>>   Statistics
>>   ==========
>> diff --git a/include/net/tls.h b/include/net/tls.h
>> index a5bc28a7d1f5..d3123b17030c 100644
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -282,9 +282,12 @@ struct tls_context {
>>       union tls_crypto_context crypto_send;
>>       union tls_crypto_context crypto_recv;
>> -    /* Registered for KeyUpdate, protected by the socket lock */
>> +    /* KeyUpdate state, protected by the socket lock */
>>       struct tls_traffic_secret tx_secret;
>>       struct tls_traffic_secret rx_secret;
>> +    u64 tx_key_updates;        /* KeyUpdates sent */
>> +    bool tx_key_update_reply;    /* peer set update_requested */
>> +    bool tx_key_update_asked;    /* we set it, no answer yet */
>>       struct list_head list;
>>       refcount_t refcount;
>> diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
>> index d1b136ecea96..c85408cb6ce7 100644
>> --- a/include/uapi/linux/tls.h
>> +++ b/include/uapi/linux/tls.h
>> @@ -44,6 +44,7 @@
>>   #define TLS_TX_MAX_PAYLOAD_LEN    5    /* Maximum plaintext size */
>>   #define TLS_TX_TRAFFIC_SECRET    6    /* TLS 1.3 TX traffic secret */
>>   #define TLS_RX_TRAFFIC_SECRET    7    /* TLS 1.3 RX traffic secret */
>> +#define TLS_TX_KEY_UPDATE    8    /* Send a TLS 1.3 KeyUpdate now */
>>   /* Supported versions */
>>   #define TLS_VERSION_MINOR(ver)    ((ver) & 0xFF)
>> diff --git a/net/tls/tls.h b/net/tls/tls.h
>> index 63ece8074985..d12c9278c814 100644
>> --- a/net/tls/tls.h
>> +++ b/net/tls/tls.h
>> @@ -151,6 +151,7 @@ int tls_hkdf_expand_label(const u8 *secret, size_t 
>> secret_len,
>>                 const char *label, u8 *out, size_t out_len);
>>   int tls_keyupdate_rekey(struct sock *sk, int tx);
>>   int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb);
>> +int tls_sw_key_update(struct sock *sk, int request);
>>   int tls_set_sw_offload(struct sock *sk, int tx,
>>                  struct tls_crypto_info *new_crypto_info);
>>   void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
>> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
>> index 543bf57599c7..851d5b54b336 100644
>> --- a/net/tls/tls_keyupdate.c
>> +++ b/net/tls/tls_keyupdate.c
>> @@ -146,5 +146,10 @@ int tls_keyupdate_rx(struct sock *sk, struct 
>> sk_buff *skb)
>>       }
>>       TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
>> +    /* Any KeyUpdate from the peer answers our update_requested */
>> +    ctx->tx_key_update_asked = false;
>> +    if (msg[4] == TLS_KEY_UPDATE_REQUESTED)
>> +        ctx->tx_key_update_reply = true;
>> +
>>       return 0;
>>   }
>> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
>> index 8bb1b2773f3f..d71de99d8890 100644
>> --- a/net/tls/tls_main.c
>> +++ b/net/tls/tls_main.c
>> @@ -765,10 +765,14 @@ static int do_tls_setsockopt_conf(struct sock 
>> *sk, sockptr_t optval,
>>           /* The registered secret no longer matches the key. The RX
>>            * secret also needs the TX one, see 
>> do_tls_setsockopt_secret().
>>            */
>> -        if (tx)
>> +        if (tx) {
>>               memzero_explicit(&ctx->tx_secret,
>>                        sizeof(ctx->tx_secret));
>> +            ctx->tx_key_update_reply = false;
>> +        }
>>           memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>> +        /* the answer now goes to user space */
>> +        ctx->tx_key_update_asked = false;
>>           return 0;
>>       }
>> @@ -987,6 +991,35 @@ static int do_tls_setsockopt_secret(struct sock 
>> *sk, sockptr_t optval,
>>       return rc;
>>   }
>> +static int do_tls_setsockopt_key_update(struct sock *sk, sockptr_t 
>> optval,
>> +                    unsigned int optlen)
>> +{
>> +    struct tls_context *ctx = tls_get_ctx(sk);
>> +    int value, rc;
>> +
>> +    if (sockptr_is_null(optval) || optlen != sizeof(value))
>> +        return -EINVAL;
>> +
>> +    if (copy_from_sockptr(&value, optval, sizeof(value)))
>> +        return -EFAULT;
>> +
>> +    if (value != 0 && value != 1)
>> +        return -EINVAL;
>> +
>> +    rc = mutex_lock_interruptible(&ctx->tx_lock);
>> +    if (rc)
>> +        return rc;
>> +    lock_sock(sk);
>> +    if (ctx->tx_conf == TLS_SW)
>> +        rc = tls_sw_key_update(sk, value);
>> +    else
>> +        rc = -EINVAL;
>> +    release_sock(sk);
>> +    mutex_unlock(&ctx->tx_lock);
>> +
>> +    return rc;
>> +}
>> +
>>   static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t 
>> optval,
>>                    unsigned int optlen)
>>   {
>> @@ -1020,6 +1053,9 @@ static int do_tls_setsockopt(struct sock *sk, 
>> int optname, sockptr_t optval,
>>                             optname == TLS_TX_TRAFFIC_SECRET);
>>           release_sock(sk);
>>           break;
>> +    case TLS_TX_KEY_UPDATE:
>> +        rc = do_tls_setsockopt_key_update(sk, optval, optlen);
>> +        break;
>>       default:
>>           rc = -ENOPROTOOPT;
>>           break;
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index cc0177320e7e..4fe78624859d 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -40,6 +40,7 @@
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>>   #include <linux/splice.h>
>> +#include <linux/unaligned.h>
>>   #include <crypto/aead.h>
>>   #include <net/strparser.h>
>> @@ -1005,6 +1006,151 @@ static int tls_sw_sendmsg_locked(struct sock 
>> *sk, struct msghdr *msg,
>>       return copied > 0 ? copied : ret;
>>   }
>> +/* RFC 9846 section 5.5 allows 2^24.5 full-size records per AES-GCM key.
>> + * Send the KeyUpdate a little earlier.
>> + */
>> +#define TLS_KEYUPDATE_TX_RECORDS    BIT_ULL(24)
>> +
>> +/* Section 4.7.3: the epoch must not exceed 2^48-1. The application
>> + * traffic secrets start at epoch 3.
>> + */
>> +#define TLS_KEYUPDATE_MAX        (BIT_ULL(48) - 4)
>> +
>> +/* Send a KeyUpdate with the current key, then install the next key.
>> + * Called with tx_lock held and the socket locked.
>> + */
>> +static int tls_tx_key_update(struct sock *sk, u8 request, int flags)
>> +{
>> +    u8 body[TLS_KEYUPDATE_MSG_SIZE] = {
>> +        TLS_HANDSHAKE_KEYUPDATE, 0, 0, 1, request
>> +    };
>> +    struct tls_context *tls_ctx = tls_get_ctx(sk);
>> +    struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
>> +    u8 record_type = TLS_RECORD_TYPE_HANDSHAKE;
>> +    u8 buf[CMSG_SPACE(sizeof(record_type))];
>> +    struct msghdr msg = {};
>> +    struct cmsghdr *cmsg;
>> +    struct kvec iov;
>> +    int ret;
>> +
>> +    memset(buf, 0, sizeof(buf));
>> +    msg.msg_control = buf;
>> +    msg.msg_controllen = sizeof(buf);
>> +    msg.msg_flags = flags & (MSG_DONTWAIT | MSG_NOSIGNAL);
>> +
>> +    cmsg = CMSG_FIRSTHDR(&msg);
>> +    cmsg->cmsg_level = SOL_TLS;
>> +    cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
>> +    cmsg->cmsg_len = CMSG_LEN(sizeof(record_type));
>> +    memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
>> +
>> +    iov.iov_base = body;
>> +    iov.iov_len = sizeof(body);
>> +    iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, sizeof(body));
>> +
>> +    /* A control record closes the open record first, so all data
>> +     * written so far goes out with the current key, ahead of the
>> +     * KeyUpdate.
>> +     */
>> +    ret = tls_sw_sendmsg_locked(sk, &msg, sizeof(body));
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    /* Nothing may be encrypted with the next key before the KeyUpdate
>> +     * is encrypted with the current one.
>> +     */
>> +    ret = tls_encrypt_async_wait(ctx);
>> +    if (!ret)
>> +        ret = tls_keyupdate_rekey(sk, 1);
>> +    if (ret) {
>> +        /* The peer expects the next key: the connection is lost */
>> +        TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYERROR);
>> +        tls_err_abort(sk, ret);
>> +        return ret;
>> +    }
>> +
>> +    TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
>> +    tls_ctx->tx_key_updates++;
>> +    if (request == TLS_KEY_UPDATE_NOT_REQUESTED)
>> +        tls_ctx->tx_key_update_reply = false;
>> +
>> +    return 0;
>> +}
>> +
>> +/* Send a KeyUpdate if one is due: in reply to the peer's
>> + * update_requested (RFC 9846 section 4.7.3), or before the key reaches
>> + * its record limit (section 5.5). ChaCha20-Poly1305 has no record 
>> limit:
>> + * the sequence number would wrap first.
>> + */
>> +static int tls_tx_key_update_if_due(struct sock *sk, int flags)
> 
> '_if_due()' ? Hmm. 'tls_tx_should_update_key()'?

A "should" name usually means a check that returns bool, like
tcp_should_autocork(). This function also sends the KeyUpdate, and it
returns -EKEYEXPIRED at the epoch limit.

net/tls already uses "maybe" for a function that acts only when needed:
tls_rx_msg_maybe_announce() in tls_strp.c. I will rename this one to
tls_tx_maybe_update_key() in v3.

> 
> But otherwise looks good.
> 
> Cheers,
> 
> Hannes

