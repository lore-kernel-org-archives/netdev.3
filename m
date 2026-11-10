Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333088;
	b=yx1LukAwvlFk5MR05RIROotY9NLeENFv3K33BnvE+P748xq+DEIk5a1zmm6K99SjI/fe
	 foE9zQByZgIhp2xKKDnsMaADY+kIyHPNR8ovvvjJOvBGtjT0nscya0qRRR2wtudq0YaSv
	 o2LF6W916hdPEx+nT7Y7H1Bs/EI4qrEjQHAzPvx8KxZ5waYKHfH9V0naxxQwx/rVDkH4Q
	 0aAI5ii2L4UQYgF7m68KhdbDByUA0EtUvNuBuL9TIk/1Hf6mp8m+t2HOYpPI7/h6iqwvX
	 rfEoO25r6sw5z3CJQjUsFMAykKpntoWo6xWlXqpzL3/S45SjBcP8EuUvqityzDliMoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CPvvNXqIc6NQ9tcR5dDa5483AHCobeaIvRqiuxHAwj0=;
	b=IS44KN86wkn9T2kONmAU9yVRcxl8zRqcut5nCNKffxYJvjTy1HdtYbf9tQPFmS1x4byr
	 +Nn7qB8g1Hg4xx3SS4wd9vpLuYZ+Y+U2qUc36P7M0fGIhs353ddGZzpjsDGkhzZnrbopY
	 SGQ+uy0K2JRSSRgXIZc+gKiiWXYNHpAmk9IeriXeacJuEE7uz5YshL0vLGhDbXJROiBGg
	 98eXaGreqBeajZknXs0+YylGXFXEeV3fCoyhx86eYNeKWNv7zkNDpOflhE0E6wvADM2BB
	 O7wYsf12g2VeXt88YgM98N/7ysgqMtTrztTjIbCbbK3pWU4ExQcCFTuyn9uN6CCFHhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GVp6fDuy;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C958606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C958606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GVp6fDuy
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-7190d9bdb2cso448983eaf.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333087; x=1794937887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CPvvNXqIc6NQ9tcR5dDa5483AHCobeaIvRqiuxHAwj0=;
        b=GVp6fDuyjzyTBe4gqu8/YTJc+c4sASOl8xSrw4IySu13ZcrDDjEEmp4DRBUGxNUuq/
         UTNz30ASl8tNE8acIwD8aE6qeOJQ3Qb6BNsvbu1HQ/vAW3WI+A3dwFgz6k1PLpyXdAMw
         kiFBiuUUB12yfFPNbbI1oyvVbeKUYigCvs2Kd1kpOq737kVX269yZtr/KNC8iFBzJXdo
         WfE2gmxbRUAiNANnr9Vh2YzVSQeneB64bsGR1DZkyALEI1i2d1BbHXnolIv73dOrdUSx
         IQY+aS+8BsdPVedmdsIWj/1WifSPeso7fXSMKEEp0jCnG8vLFKpRQ5ZHTfjfN43Nol+0
         LdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333087; x=1794937887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CPvvNXqIc6NQ9tcR5dDa5483AHCobeaIvRqiuxHAwj0=;
        b=Z8dc63C5LmhMH8wWiF1ikJelSDTQFDAM6BjBmBCw6vrVGhUSptLyBf9hfF+xjd51yM
         VbdREAdCd1RhrtY8rBkbBEQaSUzUnpzYKSf2pobISlog9nHfnBMPgGqBkDHc4tj5sHLc
         poy/EkgvmlYWUdE81+TW65Vxay1nlksUcK5erUS/sgXy8i/ea6aKhq1S0IcJ2WTXeWDc
         elmZ1xK+mzIZdU/LknRwfuU3TN3j/7D+XDIT+r1fc43gMLf0RqILQNBIpYjthmQ0/sKw
         6rF2RCEVfJpUTTxjhUPFIufMBDd7tEptoaQM9WL9zMZUeM3Pr//VI3+Fj1I8rL5WDr+c
         lgWQ==
X-Gm-Message-State: APuU4Z/gZnAv7DRdyvyS8EtrUQE1l7GJbJMJ5CBGhr+32Ta9DEW43oMN
	eP+RbTdjIocPrqyQuo+4yt3++jH2IgbILPauUpOIrMdhYDg5DGuVldGgLDdxWt5f
X-Gm-Gg: AYBFou2M49Fm23zs2frzZ+wY03EsdVn9FG9ICg1I8L5JYiiTbbZef3LKohAlWyY7gpM
	xZjR24aqii3z8USkhJvOXOIQ2WGn3Xw5TTBcRmd1L//O68KMIAid4lA6P8y2TQALEhxtcFQ5Yga
	zk+r1gN/yMLEa1omm6/5BTSpMm9Zh7/2EMaKJKk6+FF09HZf1xA5GGKqhBbqUokenN1jyXDGYCC
	H3xGWZt/kNJ69aVa9UUmwiu/Dh4FFsUJdPGdaArvnto6ETgkbR2o7ZlRYZ2x2rq/WYLRfXrFVb6
	Vh+5kCBjdqnZX2RoKI7DtThhQhOE/tHWuBMoPzOkBHGl8Arnu3rjgbVpmGE2IReK2HQt2UTrpJz
	1NJLdz8zoTEjEXdAR637TAbaYj6MefM5URAMfLdSksLf24amaP2GB/2PGt74AhxWK9NWoJJrBZ6
	7ZUty185GWKVHx7M7opVrq/5IWIZsxMdDCFUIby61+ootcIR6vWCrg45yh4lrtF4qwIXcKeJnwm
	qrWT/SJ/ZFAwbz2GWJZbPrcD+WtmATdMoNi+2N+iN5zoICcLMR7Cd44fBuFZ/dNX6QdQ+znrsup
	FJOz+38lB0b2pKvPvlYqftsT
X-Received: by 2002:a05:6820:c5cf:10b0:6f7:75ab:f969 with SMTP id 006d021491bc7-718a6e32db4mr1160034eaf.66.1794333087028;
        Tue, 10 Nov 2026 09:51:27 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718aa132e65sm1873741eaf.14.2026.11.10.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:51:25 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paul Blakey <paulb@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	dev@openvswitch.org
Subject: Re: [PATCH net v2 1/2] net: openvswitch: do not record user features when the change fails
Date: Tue, 10 Nov 2026 12:51:11 -0500
Message-ID: <20261110175111.977451-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179423057882.994134.14676780013911062883@kernel.org>
References: <179423057882.994134.14676780013911062883@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-09 08:23, Sashiko wrote:
> [Low] Is this list of reference holders accurate? Only cls_flower and
> openvswitch call tc_skb_ext_tc_enable() and tc_skb_ext_tc_disable().

Correct, and v3 says it that way: cls_flower and OVS take and drop
references, and the bridge, the flow dissector and the OVS flow path only
read the key and depend on it staying on while they do.

> [High] Can every failed OVS_DP_CMD_NEW leak one tc_skb_ext_tc reference?
> [High] ovs_dp_reset_user_features() has the same gap.
> Would it make sense to add a tc_skb_ext_tc_disable() to the
> ovs_dp_cmd_new() error path and to ovs_dp_reset_user_features()?

Both are real, and v3 fixes them along with the one the series started
with. All the paths that change or clear the bit now go through
ovs_dp_set_user_features(), which takes or drops the reference as it
records the field, so the four places that write it can no longer
disagree with the count. The failing NEW is the datapath that never
reaches __dp_destroy(), and the reset runs ahead of it for the name that
already exists.

The two tests cover the reset path: an outdated client sends NEW for a
datapath that exists, and the test checks that the datapath keeps
answering sets afterwards.

pw-bot: cr
