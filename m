Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB596485CEA
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859118; cv=none; b=EYZleNFd3KtszrWydfo/sm9kp+mlRAk3b/Fj5zcxd/ODVTUh44/YwtkDaNhs7MqGgDbJoDb9htsyutVNu69zJBoBildJX1d+tkzwIMxh0ZMb0wBG8SVvPqwGD7e+Nz/avzA1dquQ0Sd6hvaC0qxCTkbqgK9kmCA1xXe1ud79t9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859118; c=relaxed/simple;
	bh=P+0fABIIowzGr1w/6A5biYqXvfWe0LAjx/+VO8P9K1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5ULJgPEdgkFV8lZxLZZQ2EOpByjNzBkrTIU2XLBegj/QOzaWFgMTk5wnFift2vVqnCLnx3V8lrkiAc8rU/ye98xWIfwH53ccIf1WFUVL563gqVI7fORxgVb3PM6rmCcqhOQLF0QnX1LSil6W1/7wF1BofRfVH4/JyPmJHFX8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Cn1xLRW6; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Cn1xLRW6"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so3805904f8f.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790859115; x=1791463915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JFHIUwh0+wACn8HyR7pIgJ6JFS4Bsa6+XC798jCUgkA=;
        b=Cn1xLRW6DQccPYQ9D2hIIY0jpJBfE/xc+J6Y+Ixorqh2QJ1Wtci4yYesqAAq6HL64B
         iwUJH1Vj4U8W+zawSSOs6XgvddidPRvGv1dnkhJt9nuhv4sioBSwqxmP3QxKa6P7ONHe
         eGwhdvtGVKHx6ryUnWbQFhbPXuN7wdxzoQmdn8ic8tD/Vh4LceIseu7ok4VNuOZ2Vy9i
         FDITQvU3/8yP+z6eRM05J/f6M93Af7RWAdCFiWCvnmW/0RhWloVUTz7WNO9jZgUVtGYI
         yVz1ZA5ABF0I5cjhXUgD03Tqv6TTEQC5OV56zL/jK5cZp/qugO7VSCYf/cHzC/+XiAa8
         7UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859115; x=1791463915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JFHIUwh0+wACn8HyR7pIgJ6JFS4Bsa6+XC798jCUgkA=;
        b=xkbla5cAdDSzpqZjOgZeNzM4XQiAUZqblxtwr0EwyUE2beESa8bTumXg+xZ3VcK2Yb
         GlRZ4XEJAERjXZOAVORP0zqvQwgWaCoRgT4yFUN7L8kVp2YXIf2YJs/rkgTqJ3puflWE
         a65eCBEIOnQsbI1DumUbc+VHkf/Mp1zLNjtHIJh+ufOt7/qHfDMqIz8ZZf5F1NkxXtrL
         tO64OBxJCfhzO4QKqUDX/MfsJSZ1F1b9ETULVOkeZhIHK0LYZ1J8YqhIbDSGwYKbX9LN
         UCjrZbe1LcFiwjxKXSFJwHpilcZyagRVhIJX4+ziuP2lefkOf6BBKzG5XTbEjspftgrs
         Dj7w==
X-Forwarded-Encrypted: i=1; AKwUvBxbM/jHq/wJepdKhBFJdbT39qclcFEU65MjJjnkn0E+WfCxcK93EoJUNKeGiDHahwiJcsJvIp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSmUjuL4hu2wH0Oxj853M9RM15r/IBl8hv9bEYmnZhinwY6a2I
	Yzwxd6ytwkYkaYqa9YKvxKVT9ktDHqgArPznRDs02FochGO6qBc3vKFxKJ8bSXrHmE4=
X-Gm-Gg: AYBFou0xSNCoGyKjzkf0wa03rQ0Cc+H7TF5BfUrt69Miklc8FrLTLDq9jaQ+VRzgI0/
	if68nVF6YCtEbXU7jEDwfVgch7XaYM6b3sQRIjsiCWZza1AuGWPEwAKxGjQPu+6X4Kv9BJLX1Nb
	XG2WH03I+2iDYrA5tmtSxeBCR3G6e3ZNYqIKKox3ZrNzxpahYogIodvrQkBbuXtVpYf4J7UzeAU
	uSaqaGFlRDmYCRLCedOXBYclx2jSqb78+obtZ8V0NaWnGIYQYlF14G1nIQytjZ4mWDfBugcyStX
	upYnQdgVHkpDTacha+y8ZK3p5b/GL/pmSK1cDIqeHYMrpM/lC6PSNY6NlJWkCEuYU3t101gSD9t
	fQFy7MaNgjGUL6e68zDqZMLBz7F0wA7iym+0BANrm+PbllT14YBoLP7lplxtks5Za6GUnGZ2/5Y
	+Xl12lhAikvD6z9NhrbrjHdgSecRbolFREfoU2KgYZOUOFqelatg1Seqkum05+TuwsryjHkBLas
	QOfX5w2IPauZjpChsygNkpkFDAUmbHfPUAxYGIOR5P7t+atBaw2St7J3JV1IBNEv7bBuG/H7gQe
	pMtMfNzvb+H0HsN5
X-Received: by 2002:a05:6000:989:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-48b02511718mr8174236f8f.36.1790859114851;
        Thu, 01 Oct 2026 05:51:54 -0700 (PDT)
Received: from localhost.localdomain ([197.51.130.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2d12fsm5832698f8f.31.2026.10.01.05.51.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 05:51:54 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sinfo@kernel.org,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: do not offer software GSO on the amt device
Date: Thu,  1 Oct 2026 15:51:36 +0300
Message-ID: <20261001125139.17059-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAL4Wiiqw_7Mxa5W1EQgw2=KpJNNxG=cBLXsHvpio29GvD1UKZg@mail.gmail.com>
References: <20260928181554.85766-1-omar@blockcast.net> <179061959167.31693.11895969550331516671@kernel.org> <20260930222700.45470-1-omar@blockcast.net> <CAL4Wiiqw_7Mxa5W1EQgw2=KpJNNxG=cBLXsHvpio29GvD1UKZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resending with the list and Cc's restored; my first copy went to
Eric only by mistake.)

On Thu, Oct 1, 2026, Eric Dumazet wrote:
> 1)  Note that tx checksum offload is off by default on amt, so the bug
> would not trigger by default.

You're right, and I should have checked that before sending. With
tx-checksum-ip-generic off, netdev_fix_features() drops GSO_UDP_L4
from amt's features, so validate_xmit_skb() segments any UDP GSO skb
before amt_dev_xmit() sees it. It takes "ethtool -K <amt> tx on" first.

The commit message, and my reply to the bot, also overstate the
symptom. Even with tx on, the per-tunnel copy keeps csum_start on the
inner UDP header, so where it is segmented in software,
__udp_gso_segment() rejects it and the copy is dropped, rather than
being cut into malformed AMT messages. That is from reading the code,
not from a reproducer.

> 2) Please take a look at Documentation/process/coding-assistants.rst

Thanks, I have. Anything further I send that an LLM helped with will
carry an Assisted-by: tag and say what was and was not reproduced.

> 3) A better fix would be (for net-next) to call udp_tunnel_handle_offloads()
> in amt_send_multicast_data() like other UDP tunnels do

Agreed, please drop this patch. I'll do it that way for net-next,
with an amt.sh case that sends a UDP_SEGMENT burst through the relay
with tx on.

pw-bot: cr
