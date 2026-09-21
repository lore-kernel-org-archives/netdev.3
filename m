Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19071E5B9A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962526; cv=none; b=nq1o3qxzqxgNT9cVemQ6iCYuJt87g3UtPjTkmJKTazS21ZRkiCul5L93zGFnvOcubbqViaXxwzZm54hl3k7c7OTpCsnusxUJHL3Kbf/mwcPyc90bu28ibbO/IplTKORavdqSu6zJowmZfbucWxtUx37oVtPc8rYMkJACL77TOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962526; c=relaxed/simple;
	bh=Q4IOQA8Ym+dDw2UtT+U3YTePD6ShGZzG43yFkk1apGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ev+RslrY/j0gP+Sr0cVypnhjE+aGZjevzuNU6cexElZpUvcWDFEc/i0EIK6hAmi6CJCXcT2o4w3o5uaPvR9QskHHomWYB1PjJDZnwgRgVk91jD0KXp6WX+2LQlU4aSTzBvNavRzgfB0HuDdu2s7wSdWO7V9sQIj2g12ymSQ8LS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwLuPEtE; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwLuPEtE"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so2269064a91.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789962524; x=1790567324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqTMVQvfIAsf3+hPBwhpTtZWuvWW4Fga5XQay6i/cYE=;
        b=fwLuPEtE/l+rq43Gu8Ik6SNAO9S8cCW6dmcpkKaD9TbUj28nw9q51qIP6c9RTTxx8a
         ZyfknC1KC2ze+Br1RouOEa6bqDyBqM3oqp4D6yBEglHtSKbwXO+ct/vpBX7/vsAUI2I2
         m2lEuX0fC8AgncZ2DrptzzWU9OA2rZZ7o9nLK9B2PQpDO1VL+OhkweGgiSvueDgweyVj
         w887l4Xu2swS5Qpwk7eGDYNxe06m26fZAVCvD8l835a9OV48vpJmatQZMENYgP9mJOZ6
         dAJfeOCXw4xbh2Db+MZA+PIfZwiWSFi0gypUA/e8SPWDSftwZqtc0ij8MObyEjAyChb7
         jm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789962524; x=1790567324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MqTMVQvfIAsf3+hPBwhpTtZWuvWW4Fga5XQay6i/cYE=;
        b=abAqW1LHZsg1lSlpEUtfILx5CQ8kPk9CNeiBAzfStRVdWu/l0kUM2kHP/kTk8wI3Tf
         WYONuuCdvob9wnIPr1/68v75tD9uKojWsFMEA5An4u4yxOJens0MoZs3PtkNoJyC6QdY
         obtHa7mU9c2Oh5BuSvM9J6DGZojyqGyrZ09CZOP33h9AwEA43YeKStMfLufxUe5JTTrz
         ViTu0KTAN6HeQHEBG0NAbDm9F0c6a9c0EvL5+PpNrnlc7HLtau5tdKQpQU096PdpXryE
         pwHipkw4v3mzoJJ2mujKK95g/ykr/V36hJROrsd/MAOPGYgkrNVK6ZIgOPQT7/52mWZs
         1J4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzaTY5FPgy6ggWfvxwfpMXSywphAMF5KZKwbrF2Uc1UL1Rcjja9sz+9a3i9U+yJHYMabiebeFw=@vger.kernel.org
X-Gm-Message-State: AFuF++kGGdsTaK0uArU0QtaoOFI5JTyQcax4mwEzIBsglu0w3XkKQKBm
	YgTWbbIA16IivVIoDp0FcizrLuwn2WmiTFHA5F6eHd6+l3Uua+6EZvqH
X-Gm-Gg: AYBFou296My9KkZt4NCpRvo6De/eisv1Zigbv9mufkJ0pEhG0Cam4Ou7ufUC/4LwgmU
	3m1sRCWuhTSqfjJjjiVre0Q8NG7eW7+BSzrnHnKD1HfzNQ+JZ1aYlVnHsB9PNXv4AREBZzTEQP2
	4eeyWKGa0r9f+iQgjmumO8w+oa/8P+8wpRvjxeyMCAxyxFeopjmmO+nENlaE6nthycmLdsey1vG
	7CJkj+/pXVWORadk/XhmePkTFOUIsLOXOpLTsWWvmF7Jal8TqL0Iyi4ZO+dqcRIhM/U+MwXfMmn
	YFX+BW9PCz8V4E66Dj/eE922Tg+sJEOzaYgu1ifuUgBgll5+OBup3BKgLia3AXnKTi13Fa1qspZ
	WIropoMi9AsCqfWd5biVlQMSKMTqA2Gf0JvZrMLF5Zgn6dajfIcnX+/FnoSc3S3MJmJAXbAdLhc
	5OnPO1AJxeKNAudH1jzExHcOOUC61exOy04/dIaMcoc3uSHp1E7yYc1fORPvym4pnsARXw52Jtv
	IPbA2MzwkL/2w==
X-Received: by 2002:a17:90a:e705:b0:3a0:348a:5118 with SMTP id 98e67ed59e1d1-3a0348a5debmr4587419a91.47.1789962523933;
        Sun, 20 Sep 2026 20:48:43 -0700 (PDT)
Received: from localhost.localdomain ([112.49.236.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311a111sm13513743eec.6.2026.09.20.20.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:48:43 -0700 (PDT)
From: xiaoshoukui@gmail.com
To: tung.quang.nguyen@est.tech
Cc: edumazet@google.com,
	jmaloy@redhat.com,
	netdev@vger.kernel.org,
	tung.quang.nguyen@dektech.com.au,
	w@1wt.eu,
	xiaoshoukui@gmail.com,
	xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Date: Mon, 21 Sep 2026 03:47:58 +0000
Message-Id: <20260921034758.806257-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <GV4P189MB37321B67712A8B2906F2DC2DC6B82@GV4P189MB3732.EURP189.PROD.OUTLOOK.COM>
References: <GV4P189MB37321B67712A8B2906F2DC2DC6B82@GV4P189MB3732.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tung,

Thanks for the review and feedback.

On Thu, Sep 17, 2026 at 03:51:16AM +0000, Tung Quang Nguyen wrote:
> This cannot occur because the sending side already does sanity check to
> make sure that no invalid protocol type exists in bundled and fragmented
> messages.
> This only occurs when you create fake TIPC messages or tampering with
> existing messages. This is an invalid use case because TIPC is being used
> in an insecure environment. In such environment, IPSec or TIPC encryption
> must be used as mentioned here
> https://datatracker.ietf.org/doc/html/draft-maloy-tipc-01.txt#section-6

I agree that the normal transmit path performs checks that prevent the
relevant internal protocol users from being bundled. In particular,
tipc_msg_try_bundle() rejects MSG_FRAGMENTER, TUNNEL_PROTOCOL, and
BCAST_PROTOCOL.

However, I think this is separate from the receive-side skb ownership
issue addressed by this patch. The patch does not assume that these
message types are normally generated by the transmit path. It handles
the case where an skb has reached tipc_data_input() and that function
explicitly reports that it did not consume the skb.

The relevant point here is that an skb that is not consumed by
tipc_data_input() must still have a defined owner and cleanup path.

> This check is redundant because bundled messages do not contain message
> types that can make tipc_data_input() return false. The only exception
> is tampering with TIPC messages.
> If that is the case, a fake valid message type can be inserted into the
> bundle message and tipc_data_input() returns true but user applications
> are broken by corrupt messages.

I agree that a tampered message can be changed to a valid user type.
In that case, tipc_data_input() returns true and the message is queued
for further receive processing.

However, that case does not exercise the check added by this patch.
The added kfree_skb_reason() is only executed when tipc_data_input()
returns false.

The two cases therefore have different ownership behavior:

valid user type
    -> tipc_data_input() returns true
    -> skb is queued to inputq
    -> receive processing continues

unhandled protocol user
    -> tipc_data_input() returns false
    -> skb is not queued or consumed by tipc_data_input()

For the latter case, the bundle path currently ignores the return value:

while (tipc_msg_extract(skb, &iskb, &pos))
    tipc_data_input(l, iskb, &tmpq);

tipc_msg_extract() has already allocated and validated iskb before
returning it. For the protocol users listed above, tipc_data_input()
then returns false without consuming the skb. Since the caller ignores
that return value, the extracted skb has no subsequent cleanup path.

The proposed check only closes this ownership gap; it does not attempt
to solve message-integrity or anti-tampering problems.

> >+				kfree_skb_reason(iskb,
> >SKB_DROP_REASON_UNHANDLED_PROTO);
> 
> Compiling warnings:
> https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/build/1166117/14820384/checkpatch/stdout

Thanks for pointing this out. I will fix the checkpatch formatting issue
in v2.

> This check is redundant because fragmented messages do not contain message
> types that can make tipc_data_input() return false. The only exception
> is tampering with TIPC messages.
> If that is the case:
> - dropping the invalid fragmented message will cause the reassembled message
>   corrupt (For example: sending a 65KB message but dropping/truncating 1500
>   bytes). As a result, user applications receive corrupt messages.
> - a fake fragmented message can ben sent and tipc_data_input() returns true
>   but user applications are broken by corrupt messages.

Regarding the fragment path, I believe the proposed change does not drop
an individual fragment during reassembly.

tipc_buf_append() is documented to return 1 only when reassembly is
complete. For the first and intermediate fragments it returns 0. When
the last fragment is received, it validates the reassembled message,
assigns the complete reassembled skb to *buf, clears the reassembly
state, and returns 1.

Therefore, the relevant sequence is:

  first fragment
      |
  intermediate fragments
      |
  last fragment
      |
  complete reassembly
      |
  tipc_msg_validate()
      |
  tipc_data_input()

The added kfree_skb_reason() is reached only after this complete
reassembly step:

  if (tipc_buf_append(reasm_skb, &skb)) {
      l->stats.recv_fragmented++;
      if (!tipc_data_input(l, skb, inputq))
          kfree_skb_reason(skb,
                           SKB_DROP_REASON_UNHANDLED_PROTO);
  }

At that point, skb refers to the complete reassembled message, not to an
individual 1500-byte fragment.

If tipc_data_input() returns true, the reassembled skb is queued to
inputq as before. If it returns false, the complete reassembled skb is
not consumed by tipc_data_input(). Without an explicit cleanup at this
point, the reassembled skb and its associated fragment data become
unreachable.

Thus, the proposed change does not truncate a 65KB message by dropping
one 1500-byte fragment. It only releases the complete reassembled skb
when the receive-side dispatcher reports that it did not consume it.

I agree that a forged valid user type is a separate message-integrity
issue. This patch is not intended to provide authentication or
protection against message tampering; its purpose is limited to ensuring
that skbs rejected by tipc_data_input() are properly released.

Thanks again for the review.

Best regards,
xiaoshoukui
