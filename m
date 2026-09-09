Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70F566C70
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964135; cv=none; b=dKLZkp3YOsKY+JXxH57aRAw8/vAZmEOaRXIqH1s4WK2ZBKqoQrgGf/xBWFgqViy9+Mc2EkVlJiVBJAi/ZnXc+ZWm3zZ4MGPEqSevDqcCBAGaKExpi+ClgIdVq9dbV/gXdX8kDAQdMu4/fC93y2hxwB/dG8e5qqcIKPjjWEFpGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964135; c=relaxed/simple;
	bh=5q5Kxm1o6yjpU0G2siLoIK/IYDFj/Yajqsg2XUqzmxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nq5ZQxUWtGQitcVIs1LaSgmzDjOKpywRaUP9edSUmrxzMA8k4ij2K1Ny9n1u5qu4qeqrz68qsty9UQmO7CaOLeDRn2dD3ZQDPSIfYi4x70G9E5ZmZGZn32pgp9tkNJ6m7bxQHebup2S2BL87LKQYW/Au0CImbbCGk3u823q0yhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfWwwfdB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hg/82Qv4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfWwwfdB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hg/82Qv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788964131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw4e6oik4dRUDIn5qml2Np190c3xmC7+uPRws27S9Ko=;
	b=AfWwwfdBTaA/9qY9Onpbs/FlAS+myHVby8ynkLub7w+H7ewH8kWhi/Q11S5nv5rbS65bSs
	UZmpI51SCcEsS7PptJVo2kZhaB2jaR94SwPWuPPMkPg/ZKr91JjMTWWr0QSwUx5Tjo4igv
	lyg5dQa91mtkNQ40k9fBGUZyPXyi07Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-gJlEM8AzOAWXsxNBtTxUNw-1; Wed, 09 Sep 2026 10:28:48 -0400
X-MC-Unique: gJlEM8AzOAWXsxNBtTxUNw-1
X-Mimecast-MFC-AGG-ID: gJlEM8AzOAWXsxNBtTxUNw_1788964128
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a41f46d629so9697562b6e.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788964128; x=1789568928; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pw4e6oik4dRUDIn5qml2Np190c3xmC7+uPRws27S9Ko=;
        b=Hg/82Qv4t+B3UNtfe7xQvlV8voTWqcNEQXPAWUwf0U/zNaUZ3BbAA62/JPpiJZ6C9a
         heWu4XyP+tIDBQIuYRpGD1AEv9OYjzCi2eO5r8zdKdmutxxbBfK8NAUeC3sGLnayii59
         wygPcl8wRN0zhqdZ7tqWosvovariDTSqu4FLEDzKfeYl+O8JRPqPARsaMMI4ffeKNczB
         RbDjhCHdP+OfzneI/WG0LQsBRXLlzJfQY3hVhg0bj/3OiadZov3/bc1NwJORGRFdbJb5
         HU+Tk3WFVL3e8wbjgEVtULOByeY9zkX7Rs7441IV+qfp+vOUV9KqaRXj70RPsemzRRDh
         p7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964128; x=1789568928;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Pw4e6oik4dRUDIn5qml2Np190c3xmC7+uPRws27S9Ko=;
        b=JniSbx7kVA0sHHiyny061mP9qelKmrEXHuiBNWgk48UmbEsbQmI4zVNLSTMnhXh1rL
         cMFJKPI4GJJkQAtBeX8JhLOuiWGZYsxwZA+hNFhO8VfeWWGgM/9FBp82WdABlk4X3DJA
         CA7/6xZNYk6SdWWhLUSx951FX7hzOBzmUOeutw4hQiz4C+qf10i5/O5evC5eA1/3QZiR
         tFCOy/N+SqwcGu4o+UVvPeWKcJn4Vo7u1IhqcJUUxkeDxSarLZprrWukHNCbNWFgJewk
         3Czke2nHN+5O9xg557jDYSqbLhtLZCUew9W2ir25Gs+3CknNszWzVpSLinF0uZ9XCmhu
         4YYQ==
X-Gm-Message-State: AFuF++nKnqqQx/66jLyBou6lo1QV3keKiFDSNV+RZ1lbtDV8x6SzaxRw
	qhKAHexKrjtjgdLGiCaC6YfVWK9Wtqs1MBCWsaLBWO4OLejpCdviTg/oaIFMtwtj+ulIjFoHtRK
	cd7MhQRpFRNVezCczrNrRAgzWg2+5BckvMTw5Ggfyx8wAvzbKjl7/STGP+g==
X-Gm-Gg: AYBFou31rzaJIGW1K9ZurgXVVgSlhxpXocvnJvLJdrhmkH3xq866Ym0tDL9obycukfn
	kqQWUivGDsl2OqiAUGXG+I3rt8d8eTnetpvyKQS2VucRQ+kp5T+sC2egHBSKaNC345yZ4nnsWCU
	PNIp2e0ysDA/04MatcLgCYZA6/73sJGi+kp8Y5S9+UU6vdCQ90k2L5bvj9K528DpBX4w2PX9M7u
	jy063CjNPz9DBiiWOVheGLDpO9vXliDVyUo8vaTQJwDjEe4D6VS7HMbK62yUODjVgBph3WQBp3q
	9f10GSXpQPTPvScjJVh0Rkm61LEuRIQV0tSK3KruJHe1wgb3oS8CjGVbeuvR79OSmzDemL7v0Tr
	+p6ojLzyWFlTCjSFaHWNDpJUPQ+oJ
X-Received: by 2002:a05:6808:130a:b0:4bc:d58d:6cff with SMTP id 5614622812f47-4bcd58d8b6dmr10621179b6e.43.1788964127886;
        Wed, 09 Sep 2026 07:28:47 -0700 (PDT)
X-Received: by 2002:a05:6808:130a:b0:4bc:d58d:6cff with SMTP id 5614622812f47-4bcd58d8b6dmr10621128b6e.43.1788964127326;
        Wed, 09 Sep 2026 07:28:47 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b96babc2c3sm18029742b6e.0.2026.09.09.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:28:45 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  kuba@kernel.org,  pabeni@redhat.com,
  edumazet@google.com,  horms@kernel.org,  shuah@kernel.org,
  linux-kselftest@vger.kernel.org,  dev@openvswitch.org
Subject: Re: [PATCH v3 1/2] selftests/net/openvswitch: add SCTP flow key
 test over IPv6
In-Reply-To: <20260906165251.1176875-2-houminxi@gmail.com> (Minxi Hou's
	message of "Sun, 6 Sep 2026 12:52:50 -0400")
References: <20260906165251.1176875-1-houminxi@gmail.com>
	<20260906165251.1176875-2-houminxi@gmail.com>
Date: Wed, 09 Sep 2026 10:28:43 -0400
Message-ID: <f7t33vio5wk.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Minxi Hou <houminxi@gmail.com> writes:

> The merged SCTP test covers only IPv4. The SCTP branch of the IPv6
> extractor (the proto=132 walk after parse_ipv6hdr) and the v6 side of
> the SCTP netlink validation (match_validate() requires the sctp() key
> whenever ipv6(proto=132) is matched) have no selftest coverage.
>
> Add test_sctp_connect_v6 mirroring the v4 test: bare icmpv6() flows
> forward NS/NA, and ipv6(proto=132),sctp(dst=4443)/sctp(src=4443)
> flows gate the association in the same three phases (flows installed,
> removed, reinstalled). After the association succeeds the test also
> pushes a known payload across and waits for the listener to log it,
> proving the datapath carries the association's traffic end to end,
> not only its handshake. Skips when the sctp module is missing, socat
> lacks SCTP support, or IPv6 is unavailable; an association or payload
> failure with the flows installed fails the test.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index a31f7fb6882d..0926e304ed88 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -34,6 +34,7 @@ tests="
>  	trunc					trunc: output truncation
>  	icmpv6					icmpv6: ICMPv6 echo type match
>  	sctp_connect_v4				sctp: SCTP flow key matching
> +	sctp_connect_v6			sctp6: SCTP flow key matching over IPv6

This series has a spacing alignment issue in the test list (line 37
doesn't align with the others).  This is the third version where basic
formatting issues appear in this same block, and it is indicative of a
larger problem.  I do understand you're trying to address feedback in a
timely fashion.

I need to be direct: submitting patches with preventable formatting
issues suggests they're not getting a careful final review before
firing off 'git send-email'.  These kinds of errors create unnecessary
review cycles and CI burden.

Before submitting, please review your own patches with the same care a
maintainer would.  You should be checking the functionality, and the
architecture, yes.  You should make sure all of the feedback is
addressed, yes.  BUT you also need to care for formatting, alignment,
and style consistency.  A pre-submission checklist might help catch
these.

I'm setting this series aside for now.  Please resubmit when you've had a
chance to do a thorough self-review.  That may take more than 24 hours.
Please don't rush this important pre-submission step.

>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -700,6 +701,100 @@ test_sctp_connect_v4() {
>  	return 0
>  }
>  
> +# sctp_connect_v6 test
> +# - sctp(dst=4443) matches client-to-server INIT
> +# - sctp(src=4443) matches server-to-client INIT-ACK
> +# - icmpv6 NS/NA flows forward neighbour discovery
> +# - remove flows and verify connection fails, reinstall and recover
> +test_sctp_connect_v6() {
> +	local t="test_sctp_connect_v6"
> +	local v6="eth_type(0x86dd),ipv6(proto=132)"
> +	local payload="SCTP6_DATA_OK"
> +	local rxfile="${ovs_base}/${t}/sctp-rx.txt"
> +
> +	modprobe -q sctp 2>/dev/null || return "$ksft_skip"
> +	socat -V 2>&1 | grep -q "define WITH_SCTP" || return "$ksft_skip"
> +	[ -e /proc/sys/net/ipv6 ] || return "$ksft_skip"
> +
> +	sbx_add "$t" || return $?
> +	ovs_add_dp "$t" sctp6 || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "$t" "sctp6" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add fd00::1/64 dev c1 nodad
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add fd00::2/64 dev s1 nodad
> +	ip netns exec server ip link set s1 up
> +
> +	# NS/NA forwarding
> +	ovs_add_flow "$t" sctp6 \
> +	    'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp6 \
> +	    'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
> +	    '1' || return 1
> +
> +	# SCTP port matching: dst for request, src for reply
> +	ovs_add_flow "$t" sctp6 \
> +	    "in_port(1),eth(),$v6,sctp(dst=4443)" \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp6 \
> +	    "in_port(2),eth(),$v6,sctp(src=4443)" \
> +	    '1' || return 1
> +
> +	ovs_netns_spawn_daemon "$t" "server" \
> +	    socat -u -t 1 SCTP6-LISTEN:4443,fork \
> +	    OPEN:"$rxfile",creat,append
> +	ovs_wait sctp_eps_has server 4443 || return 1
> +
> +	info "verify SCTP association with port-keyed flows"
> +	ovs_sbx "$t" ip netns exec client \
> +	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null \
> +	    || return 1
> +
> +	info "verify SCTP DATA chunk crosses the datapath"
> +	ovs_sbx "$t" ip netns exec client \
> +	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" \
> +	    <<< "$payload" || return 1
> +	ovs_wait grep -q "$payload" "$rxfile" \
> +	    || { info "server did not receive SCTP DATA payload"
> +	         return 1; }
> +
> +	ovs_del_flows "$t" sctp6
> +
> +	info "verify connection fails without flows"
> +	ovs_add_flow "$t" sctp6 \
> +	    'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp6 \
> +	    'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
> +	    '1' || return 1
> +
> +	ovs_sbx "$t" ip netns exec client \
> +	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null \
> +	    >/dev/null 2>&1 \
> +	    && { info "connection should fail without flows"
> +	         return 1; }
> +
> +	info "reinstall flows and verify recovery"
> +	ovs_add_flow "$t" sctp6 \
> +	    "in_port(1),eth(),$v6,sctp(dst=4443)" \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp6 \
> +	    "in_port(2),eth(),$v6,sctp(src=4443)" \
> +	    '1' || return 1
> +
> +	ovs_sbx "$t" ip netns exec client \
> +	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null \
> +	    || return 1
> +
> +	return 0
> +}
> +
>  # psample test
>  # - use psample to observe packets
>  test_psample() {

