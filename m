Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F24D98E4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812250; cv=none; b=H9NsUh1V3W2moxT7iGyk2iwfBsovFl5yPtKxMVidXV2fa3mewjaj1ReimYdWEjKfidmE8qBVIiXa/8o71YAG5C1NyPuWKNSGLHGuxJAyfKgp1gkjsGpa0Kyrkk8NLlLcMd920WSckA9dgqK2+1PZM/si6Q6hxsr9Jjdrm/D4An0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812250; c=relaxed/simple;
	bh=m/JXpgiE2QOgEEX7nqmJBPlGCCOKEN0EmJS8OsAQXRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8Lx0gEkM3/4os7eaW4q4vgNbXNboDcJ2i80XEiibzHUjdLwNW0rODb4sdtEHY5euEx6h4Mb+qM4OJmf92lNLt1CRpa960Kgp9yqK/7YFWmYjx7/i4pD+/77Uo+bnhOeNMRF1v1Oylko2B0Q9XuWDAHNQLpAFVNUX/axU+f/4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9572A1F000E9;
	Thu, 23 Jul 2026 13:10:45 +0000 (UTC)
Date: Thu, 23 Jul 2026 06:10:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org
Subject: Re: [PATCH net-next v5] selftests/net/openvswitch: add SCTP flow
 key test
Message-ID: <20260723061037.257f3da5@kernel.org>
In-Reply-To: <20260723084203.3483560-1-houminxi@gmail.com>
References: <20260723084203.3483560-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 04:42:03 -0400 Minxi Hou wrote:
> Add test_sctp_connect_v4() to verify OVS can match on SCTP flow keys
> (sctp src/dst port).
> 
> The test sets up client and server namespaces connected through an
> OVS bridge, installs port-keyed flows, and verifies:
>   - sctp(dst=4443) matches client-to-server INIT
>   - sctp(src=4443) matches server-to-client INIT-ACK
>   - removing flows drops the connection
>   - reinstalling flows restores connectivity

Fails in NIPA:

# Traceback (most recent call last):
#   File "/srv/vmksft/testing/wt-2/tools/testing/selftests/net/openvswitch/ovs-dpctl.py", line 3169, in <module>
#     sys.exit(main(sys.argv))
#              ~~~~^^^^^^^^^^
#   File "/srv/vmksft/testing/wt-2/tools/testing/selftests/net/openvswitch/ovs-dpctl.py", line 3150, in main
#     ovsflow.add_flow(rep["dpifindex"], flow)
#     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/srv/vmksft/testing/wt-2/tools/testing/selftests/net/openvswitch/ovs-dpctl.py", line 2751, in add_flow
#     raise ne
#   File "/srv/vmksft/testing/wt-2/tools/testing/selftests/net/openvswitch/ovs-dpctl.py", line 2743, in add_flow
#     reply = self.nlm_request(
#         flowmsg,
#         msg_type=self.prid,
#         msg_flags=NLM_F_REQUEST | NLM_F_ACK,
#     )
#   File "/usr/lib/python3.14/site-packages/pyroute2/netlink/nlsocket.py", line 870, in nlm_request
#     return tuple(self._genlm_request(*argv, **kwarg))
#                  ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3.14/site-packages/pyroute2/netlink/generic/__init__.py", line 126, in nlm_request
#     return tuple(super().nlm_request(*argv, **kwarg))
#   File "/usr/lib/python3.14/site-packages/pyroute2/netlink/nlsocket.py", line 1214, in nlm_request
#     for msg in self.get(
#                ~~~~~~~~^
#         msg_seq=msg_seq,
#         ^^^^^^^^^^^^^^^^
#         terminate=terminate,
#         ^^^^^^^^^^^^^^^^^^^^
#         callback=callback,
#         ^^^^^^^^^^^^^^^^^^
#     ):
#     ^
#   File "/usr/lib/python3.14/site-packages/pyroute2/netlink/nlsocket.py", line 873, in get
#     return tuple(self._genlm_get(*argv, **kwarg))
#                  ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
#   File "/usr/lib/python3.14/site-packages/pyroute2/netlink/generic/__init__.py", line 123, in get
#     return tuple(super().get(*argv, **kwarg))
#   File "/usr/lib/python3.14/site-packages/pyroute2/netlink/nlsocket.py", line 550, in get
#     raise msg['header']['error']
# pyroute2.netlink.exceptions.NetlinkError: (22, 'Invalid argument')
# TEST: sctp: SCTP flow key matching                                  [FAIL]
