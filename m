Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38330DEA3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242087; cv=none; b=SUIg7poHUJKHY4hc7KUBxk8fp5pHB14rN843EN4LC4IOBUVx6BiF1IWNoXER81dWyeTRuYcYsPbeEE7X/hMbS+uXojfMmaQfLUyuKfH5MNBkp0S7OC+sAI2Kh4QWqir4tXkJgmxG7TqIcVyrwRfowwEE8vtuySCiHO3hf5S/2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242087; c=relaxed/simple;
	bh=Hlszs1lgDhouNjnFQH1cJ3xFldPAp2pCqlTCNr2La3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMoOiqxahy5dD0vIio/aruhee6zakZHxxdQf3YzgGJ5SR4h0jDbNuCWiTtsyzbCv1cfuLP6eG7dERGSU2fV3869YTnvkbpTlTNM1Q+h+2MRn7BiQd59Ih3nEc4+GzLqgCQDcmJxIc4JUXtNya2ar1rEmvueEVZX5nrf1WIyetHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=S5X0xXJx; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="S5X0xXJx"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32ba4885063so1173817eec.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790242083; x=1790846883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8lTk7fn/PC3v6nlTQj9tEX3jnHk+4TZJWs/PbeSG7A=;
        b=S5X0xXJxiNS2B/N54utGAok7KWtoSZ6lLXIf2L8qBtPOKFMIDRkFxvMSE5/V0l8Vf4
         e+f8ZB6qFCdbiLlPzStZZ+EuExGgBXbVzZuvVmhKYNRFh7MyA5ATac5X5S9aAN4oh3u5
         v6/DQU9jNPPxpm8F/ujGFwEiDGZr3qSq2Aww2kMZZCBubzpshjS1yBn5P5pdLAfrUuS1
         svC0M8Xec02Bh+Mx0ipBoL2aUscpBPbLH5OVEawoI6pcNsoQG5BtLCpw/41huifXEXMC
         33TtcyNk+3OMKTLoP8b5Ko70Veo8lEKe3NVPUaTfZpoZU5Ch74zRQ7MN+eiVLETTmsb6
         cYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242083; x=1790846883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8lTk7fn/PC3v6nlTQj9tEX3jnHk+4TZJWs/PbeSG7A=;
        b=UJjIT0kc9xTnW5rZFdHbRrTl8XN18rUvT2tCkxi6n1LcrliJ6fiwOBrbX9EZ9D++1b
         tm6tpPdJXcfFioaztZ0YVnaLOtuFM7yk/uIpOJLBTWQfS+xp/rfKb+McGimgBFShZeGX
         IEPLKigTylYfmhxXCdVEUX0gs+GWV6mxzz31WoHD+eB94MOe7Z5t6BEVLHB111j+iwrV
         Xi5KOFmG95HbpygCXAbtIFeoIHdBEK3jCl0eW9GWATUZutTt25fO+iBnTW4QiZWzj+Up
         CcFR3DeaIhkS2kM5X94WLUENATXQXlD770XK/6k2G85+79itHTDRUibzegilWi2OyJiz
         QpkQ==
X-Gm-Message-State: AFuF++k9LYpGEuIHbt6MEx0PZ9TrlXaXtMhlygXhM/SwAkTBBQjydSQ6
	2ZOBEaarJkuYN/WpCWi9gNZC4ImodISzPRYgk2nVitSPDGiUxYMEpUVNjKu1c+wNbPTfRbJMiz0
	8odF2Yq2KdOMJ4sWO5Ez/e2VG3Pe8NDJzS6O9TAe4tOOh82HyeJRb2KJCP4y5SdzqIijNxQ1U8W
	8=
X-Gm-Gg: AYBFou1jPyA2tjmUCdoZm3nNBAs6AqdN/aCxj8WfByYhmdNQq6eMqWRIxmz5Ooj6XCg
	rYu06BucfATgZIUWDs+E8F2QA0zmA+rFkTOEzUwsyiIXDx+SxG7ROreYus6BGmLtyUaPho6bSnf
	wuVZIqYAXkjEUJJT9jClJkCcnTm9kQn+0EhjuI+g+UxtNXDmuQTks3W162qJ8wDsftgKqvFuFuU
	FeTUg3yjl/G2FfKi0e3C6+tWUNWTLeuoe0vv2dfmxCLmTY3KgzamOE01OiyS6T2JtgqrTg4cOHc
	gIczB8Qh/Yda8UuIdtfM5XlPUo3Q+QsllfBpGeXkozNIQF+UcuAvUB7jUkXkjye3M6crImHFEuY
	X8XjS5Mom/AGkcij68MdpXKoLK2JMS4aCMuJJQC2MQceNx4OGgwtbzroNkGQHXCJUSS880hpoHt
	EUqYSVo5JEp95HKQFPNhfuHBTcz96UBEU+Zawiw1jRFjnjCdxXC9QURJgvU8KRGqC+7TnI/j8ll
	e+kBq22ZuotyEk3gQRY7A==
X-Received: by 2002:a05:7301:4592:b0:33b:f153:92c2 with SMTP id 5a478bee46e88-34000c2d7e2mr1978384eec.23.1790242082584;
        Thu, 24 Sep 2026 02:28:02 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625921asm12503976eec.15.2026.09.24.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:28:02 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Thu, 24 Sep 2026 17:27:53 +0800
Message-ID: <20260924092753.4183347-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.203ea450da2a2@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com> <20260920131231.3610688-1-wang.zhan@smartx.com> <willemdebruijn.kernel.eb2b72530041@gmail.com> <20260923103825.4000903-1-wang.zhan@smartx.com> <willemdebruijn.kernel.203ea450da2a2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 12:44:27 -0400 Willem de Bruijn wrote:
> Wang Zhan wrote:
>> On Mon, 21 Sep 2026 17:07:09 -0400 Willem de Bruijn wrote:
>> > Somewhat tangential, but an entirely different practical approach
>> > could be to disable BIG-TCP when such a patch from BIG-TCP capable to
>> > non-capable device is encountered.
>> 
>> That means a single device in the topology which does not support BIG TCP
>> forces every other device to turn BIG TCP off, to avoid the degradation.
>> So with mixed devices and a dynamic topology, BIG TCP cannot be enabled at all.
> 
> True. A question is how likely such a scenario with mixed devices is.
> I.e., is it worth the code complexity.

I cannot say how common the mixed case is, but with this patch enabling
BIG TCP on a device becomes a local decision: if the peer supports it the
path is faster, and if it does not the path stays at what it would be
without BIG TCP.
