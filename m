Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87831E849
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354442; cv=none; b=Rv8Xl4dFR++y6/AJlE6r5FXC7EUcM7zM1hlk0T4FaOyYLTsR8bMvUAk6S5HBdaHZV0UfAHvmHq64zOwZX1LM+O2dDgQshePHuNLhJrY+3QHOGmdx6JAkMrItNGAkb2k8wsqNRbhLOc/AyqRwHpMkbmiWogq7NxmijfeWVu6cH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354442; c=relaxed/simple;
	bh=h3X+X3oJP6ig425lm9pD8HkEPc/njyOz8m5ZW1Mv2D8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhk8qwnWQu6ysWZWLrHCyV4bCEdTxIjkSrHgO23gPFomWeOnNsyK3Jz4mF3rN/Pl34qYavt7j/VvNdbOsJsbv01hHdZIwiAjX5VdtKJlj9AnRMc/EDofw5VORcqmC/JDLcQPQOAlYNIV1elVfxHugF2fUOUPY3DPrzGETzjXw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTMJBi2C; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTMJBi2C"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f71437218so7297101b3a.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777354440; x=1777959240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=scxMaFauNo4k8LgvQ8pG6C1g76/6aWLk2adsA86hmWE=;
        b=FTMJBi2CLebD3F9HQGNBe73uOETAwDGU+jBHlSGKgzMeJaNx+6XRsd8UWHQ6Uizpt9
         mB+4TcmlKEwEG+2cyzZ/5TFdShFehwgKmaUYu3k+WFsDyC6D+3AsxSX3P9ZL4LTm58Pi
         zIehtzO9TGKRUozP+wfCdH5B4PLW6nv39tflKg67tPEOrufYj7+DBEgNzybIE0P8bKcH
         vJPRBECHueiVNTYERtycIOTXYeMH4F9njewzVvQj/Ltu0IakNtg7pLF4r+KeL7+DXx5w
         OgM+CLCVv5i35HXPLaNsqgGfHoluP+FVnxfjrg5IaVuB80CWXOC5wc6+cz1fu7OeK6Cy
         iXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777354440; x=1777959240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scxMaFauNo4k8LgvQ8pG6C1g76/6aWLk2adsA86hmWE=;
        b=QdZdthrSgXtiiTEDkub5hrowzznSL7L35dWKmWScogLfKIQfeAcThtda7Ir12MB5VQ
         43uMPxErWd7DGmdy2mlksh6EKQzpNg6jhAe2emO93KYtKqCMSX2fqb+6bfnW9Cw1GR5m
         Tvd0sGOxpLzdpAtvwReIBjVTQBsm5/gShhh+LTTCJ6aZE9c/X9BNRWbKqT2SpLWvXCm7
         Iv1e6z38R4f4r/V5xKFaHr59OmMUzLRNExIim2L7ki/1C+1XQ7z5MhhF8OhFfA4235O1
         D1arI+P2X/cx9ZJrwOFlW6sXrL9oHDsJbMDITDxkvjE9Xrkv+I0FuCLCIGg4lFg9MWf3
         G0NA==
X-Forwarded-Encrypted: i=1; AFNElJ8v0Fg64kuF/OqnSd2xeRii0H60rfwXY3qA6AyBuBPNfpewGz6SNGqrHeBcStPAO/5ouy7NRXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1KbftRjZbes9V9HP7tv0Ku+zbvm+Hh3uJ5KT5SNHE8xCcmCn
	SVy8f88izyTw9cpzBZACe7VrLEPVdktj446DON+1h3Ev3oH97baLNh+x6+6AnUR5RMcHUo8ad23
	AxKoeDQ==
X-Received: from pfbld13.prod.google.com ([2002:a05:6a00:4f8d:b0:82f:d8c0:fef8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:99d0:0:b0:834:dfb5:6e73
 with SMTP id d2e1a72fcca58-834dfb57198mr708610b3a.5.1777354439890; Mon, 27
 Apr 2026 22:33:59 -0700 (PDT)
Date: Tue, 28 Apr 2026 05:33:53 +0000
In-Reply-To: <20260426165350.1663137-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260426165350.1663137-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428053357.2188453-1-kuniyu@google.com>
Subject: Re: [PATCH net] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: bestswngs@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, martin.varghese@nokia.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, willemb@google.com, xmei5@asu.edu, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 26 Apr 2026 09:53:51 -0700
> bareudp_fill_metadata_dst() passes bareudp->sock to
> udp_tunnel6_dst_lookup() in the IPv6 path without a NULL check.
> The socket is only created in bareudp_open() and NULLed in
> bareudp_stop(), so calling this function while the device is down
> triggers a NULL dereference via sock->sk.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>  RIP: 0010:udp_tunnel6_dst_lookup (net/ipv6/ip6_udp_tunnel.c:160)
>  Call Trace:
>   <TASK>
>   bareudp_fill_metadata_dst (drivers/net/bareudp.c:532)
>   do_execute_actions (net/openvswitch/actions.c:901)
>   ovs_execute_actions (net/openvswitch/actions.c:1589)
>   ovs_packet_cmd_execute (net/openvswitch/datapath.c:700)
>   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
>   genl_rcv_msg (net/netlink/genetlink.c:1209)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
> 
> Add a NULL check returning -ESHUTDOWN, consistent with the xmit paths
> in the same driver.
> 
> Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
