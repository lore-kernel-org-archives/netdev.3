Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671379;
	b=H6TvGY/OCv15tIfCunfiIjDRIM+LpwKQ9no1MrW1NVI+PvGFjO7hqZ4wxqn2427D/W1G
	 jgzK6A1wqAZVNlRDAnHbRXeMu59wIqP0q3Cx3M7MF5cx8a05tXSbpOjA8/zpjYYZx3t46
	 bgM5JfiwBbFWVVOPXUwSMTQtfR/XjVZxQpyX4zUkdJTQj6xUaNgX7KmKZov7bC/yjpyLO
	 9qTX2mug0Y4+yCxhh8sfRe/cnxxdD5YKN07nV47CexczPtzPyGB3ix2seCL70x7hypy4g
	 pG4LI/wdsxzYJ2Chg/9Ks9inan6onJogT2UzduNjPb7Xb0gNy+n/TD+g7vrrFiBLllg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ItMI9v7HqyQTi6tvBobQdB2WA7pg1kA6+UjyQnEKsL4=;
	b=Lj8CvwObEE1VNj3dNl8nUPO+0YUgR25Bii/qKnSu+VfU4hyZ+NilgkZ24jMufLzHVnRP
	 xAywTDn0ZunnJAa7/1cd0lYlMbbqo54Mou4sV4aB3wFBp1gsEn3+jEAwROwkRgUaL8ykK
	 2wyRR5CLAeuM0RLRjZ6UIG7vUWBdFML0/q+U3tdkfTks34BiMuJmi8E1sJZzfFf044QWJ
	 xRE8Sn1SrusN3nRaETFKxa3mVB0kE8ELaMcpUk7/7oxiBC8hJ5qa54SKwb8vNe19Ro7J9
	 /DSt0hZiE1jxdo0tEivvxcQ7HIbEFz4gndVhEfU1LOTTMvcTcVvmmYcApdq8Jy0K5fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AymNEa5r;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46948606A329
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46948606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AymNEa5r
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so10761395e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671372; x=1793276172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItMI9v7HqyQTi6tvBobQdB2WA7pg1kA6+UjyQnEKsL4=;
        b=AymNEa5rkur2I6j6ozCYqsEkSogfa9UXvlJqbP38P9mZfk8rZEFAu1xnfLX7OSlluH
         ekaRaFQbrCC4gcV7DLramDbipgP0noNz4RGwguIQ0I2fGCo+7EU0oO1zR3kM9Yr+RuPw
         ufavZmbdtW/dsSCXyFnmMiGaqnNZHlwBBFXi4iniPjP02GOl1yEXPvOQ/Vm4fRzMoNgg
         BTd6ckcGRixSCQpj/qSru30FCBiY+eZpqzcayHHglS84GABuKkzO+B4AeEns3M52PczT
         Ipakf7NHqgcD7FtgJhqKZCiDa3s/eePfo+8+cydgIC//h78DUdrYQQ7ttWMb4S9iHFIg
         TcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671372; x=1793276172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItMI9v7HqyQTi6tvBobQdB2WA7pg1kA6+UjyQnEKsL4=;
        b=fmu/Img+/bb2SX/N1pO7Ly0TiaAp8vwTN8LGRFMDDWq6BYlBk4uoj/NgND0hXtW02o
         sasv9n0ZIKgLxKDee/sBbZzw0+/Lze3lRP8ubpjUkkjV2PutwG8ZgzEaHbNlyWIbERn6
         fONNpV4/ejTyWhJSYMoQDgTZoUAefPSXDyDjM/BfUeEqtoilI/ALzpqKt0X4JnR3q6IB
         eYRTEMJtuo//8BFA2yhwcvxLhfyBjM3eTNhouFhdRjsM/2+webhK4gndmB6DW4x5JaUZ
         mxhHi1bzgS/ObYxvoSzPrufms3+8wOqQbN2Uf3MY+3v2A2xt0DbyA6bpNin7LcUC15Dr
         9N6Q==
X-Gm-Message-State: AFq9FYIv3HnwRz0aWoaxCOcJI9wCEZHmuLmh8ZRG/67fJVi1P1qr2X+D
	EFCp3gBJ+KOVha3wmdvfWRDnLPYT6PD8P0dv4pJcpVdpVNYLKKo5RlV9NgVtFPhpUYnNA1jFikF
	+/wUJt4aR4zI7nIC5ozMbmL1FXHPXdV9bNOBqmOBILp6Xq8fNWZ7nPzXR5OKUb5w1H3w=
X-Gm-Gg: AYBFou1CYL8wamwBjJ1VX0fuiJgWVThZDuceStrEKoO8rnhYGp5pygzMpBMYRouy4A0
	swyYlnG0yJ56WV3azlzb4QjKAj5eqLy7aJ6Ss0FAzahORo25CVuD+PuSIhWpEmAv7nV58D/HRed
	JIhNdvetb0Houyhwie7aDUe+eG5VOgOCc/WqJoSiL12D2ohlTyPnF6D2MSJRDzOHnMUfdIg2wc4
	oOUJL3VB70j9NR3VIeB7+VCjcLyYeFCb8ufLgSBSzaN5HFVNBk+Sk51iqG79hdLFsh1zUA8/4Bf
	AseMnfmsCsH6wlSw6FwBudPFA3EP+2btBesFY1ZWBTMoLrrv7Id/EOv3xw+7rZamthWWTcg6z5W
	ClMeuwNebSbRI7gnnN43j09g5tPB4NaKD6gcq0Mo31v7p+Ic22YXm6dfy2vJLp/ksdxkrX8xGRR
	6XrA1OjQ/n4QMWGRW/kHw/unbxWLlFIfvlRk5CXa0I3yWMukgQ2zONBaaPpaas0fDCHB7xJm8w9
	7zN3Mbas6gPO/zkNCu69PuQByIXmOJ9ACnYD4AcgHhL2o0ZbfL/gyrjUHElQvt1yB75e6xCSI5c
	O+hjWfTSZiXs
X-Received: by 2002:a05:600c:4fcb:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4a208834e31mr29753115e9.22.1792671372408;
        Thu, 22 Oct 2026 05:16:12 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:12 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/7] ovpn: reject UDP remotes incompatible with socket family
Date: Thu, 22 Oct 2026 14:15:46 +0200
Message-ID: <20261022121606.732029-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn accepts a userspace-provided socket and a peer remote endpoint
through netlink. For UDP peers, the remote endpoint family selects the
transmit path used later by ovpn_udp_output.

Reject UDP peer remotes that are incompatible with the socket state when
they are configured through netlink. An IPv4 UDP socket cannot be used
with an IPv6 remote endpoint, and an IPv6-only UDP socket cannot send to
an IPv4 remote endpoint. Reporting this at setup time gives userspace a
clear extack and avoids installing a peer that would immediately be
unable to transmit.

Accepting an IPv6 remote on an AF_INET socket is also unsafe. On TX,
ovpn_udp6_output() hands the socket to ip6_dst_lookup_flow(), which
dereferences inet6_sk(sk), e.g. to read srcprefs in
ip6_route_output_flags() when no local address is set. inet6_sk() is
NULL for AF_INET sockets, therefore the first packet sent to such a
peer triggers a NULL pointer dereference.

This validation only covers the socket state visible while the netlink
request is handled. The socket remains owned by userspace after it is
attached to ovpn, so userspace can later change properties such as
IPV6_V6ONLY or IPV6_ADDRFORM. The transmit path therefore still has to
re-check socket/remote compatibility before sending.

Parse the remote endpoint once in the peer new/set paths and reject UDP
remotes when the provided socket cannot send to them. Pass the parsed
endpoint into the common peer modify helper so the validation and the
stored endpoint use the same normalized sockaddr.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 128 ++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 1af7e0e624ba..bf27a7a89f76 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -310,15 +310,17 @@ static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
  * @peer: the peer to modify
  * @info: generic netlink info from the user request
  * @attrs: the attributes from the user request
+ * @remote: remote address, if provided
  *
  * Return: a negative error code in case of failure, 0 on success or 1 on
  *	   success and the VPN IPs have been modified (requires rehashing in MP
  *	   mode)
  */
 static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
-			       struct nlattr **attrs)
+			       struct nlattr **attrs,
+			       const struct sockaddr_storage *remote)
 {
-	struct sockaddr_storage ss = {};
+	struct sockaddr_storage empty_remote = {};
 	void *local_ip = NULL;
 	u32 interv, timeout;
 	bool rehash = false;
@@ -326,15 +328,15 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 	spin_lock_bh(&peer->lock);
 
-	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss)) {
+	if (remote) {
 		/* we carry the local IP in a generic container.
 		 * ovpn_peer_reset_sockaddr() will properly interpret it
-		 * based on ss.ss_family
+		 * based on remote->ss_family
 		 */
 		local_ip = ovpn_nl_attr_local_ip(attrs);
 
 		/* set peer sockaddr */
-		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
+		ret = ovpn_peer_reset_sockaddr(peer, remote, local_ip);
 		if (ret < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(info->extack,
 					       "cannot set peer sockaddr: %d",
@@ -372,7 +374,7 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 	netdev_dbg(peer->ovpn->dev,
 		   "modify peer id=%u tx_id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
-		   peer->id, peer->tx_id, &ss,
+		   peer->id, peer->tx_id, remote ?: &empty_remote,
 		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
 
 	spin_unlock_bh(&peer->lock);
@@ -383,12 +385,45 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	return ret;
 }
 
+/**
+ * ovpn_nl_udp_remote_compatible - check if a UDP socket can use a remote
+ * @sk: UDP socket to validate
+ * @remote: remote endpoint to validate against the socket
+ * @extack: netlink extended ACK for reporting validation errors
+ *
+ * Return: 0 if the remote endpoint is compatible with the socket or a negative
+ * error code otherwise.
+ */
+static int ovpn_nl_udp_remote_compatible(const struct sock *sk,
+					 const struct sockaddr_storage *remote,
+					 struct netlink_ext_ack *extack)
+{
+	const unsigned short sock_family = READ_ONCE(sk->sk_family);
+
+	if (sock_family == AF_INET && remote->ss_family == AF_INET6) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "UDP socket is IPv4 but remote is IPv6");
+		return -EAFNOSUPPORT;
+	}
+
+	if (sock_family == AF_INET6 && ipv6_only_sock(sk) &&
+	    remote->ss_family == AF_INET) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "UDP socket is IPv6-only but remote is IPv4");
+		return -EAFNOSUPPORT;
+	}
+
+	return 0;
+}
+
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct in_addr vpn_addr4 = { .s_addr = htonl(INADDR_ANY) };
+	const struct sockaddr_storage *remote = NULL;
 	struct in6_addr vpn_addr6 = IN6ADDR_ANY_INIT;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
 	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct sockaddr_storage ss = {};
 	struct ovpn_socket *ovpn_sock;
 	struct socket *sock = NULL;
 	struct ovpn_peer *peer;
@@ -459,26 +494,34 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto peer_release;
 	}
 
-	/* Only when using UDP as transport protocol the remote endpoint
-	 * can be configured so that ovpn knows where to send packets to.
-	 */
-	if (sk_is_udp(sock->sk) &&
-	    !attrs[OVPN_A_PEER_REMOTE_IPV4] &&
-	    !attrs[OVPN_A_PEER_REMOTE_IPV6]) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "missing remote IP address for UDP socket");
-		sockfd_put(sock);
-		ret = -EINVAL;
-		goto peer_release;
-	}
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss))
+		remote = &ss;
 
-	/* In case of TCP, the socket is connected to the peer and ovpn
-	 * will just send bytes over it, without the need to specify a
-	 * destination.
-	 */
-	if (sk_is_tcp(sock->sk) &&
-	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
-	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
+	if (sk_is_udp(sock->sk)) {
+		/* Only when using UDP as transport protocol the remote
+		 * endpoint can be configured so that ovpn knows where to send
+		 * packets to.
+		 */
+		if (!remote) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "missing remote IP address for UDP socket");
+			sockfd_put(sock);
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		/* can the socket be used with this remote? */
+		ret = ovpn_nl_udp_remote_compatible(sock->sk, remote,
+						    info->extack);
+		if (ret < 0) {
+			sockfd_put(sock);
+			goto peer_release;
+		}
+	} else if (remote) {
+		/* In case of TCP, the socket is connected to the peer and ovpn
+		 * will just send bytes over it, without the need to specify a
+		 * destination.
+		 */
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
 				       "unexpected remote IP address with TCP socket");
 		sockfd_put(sock);
@@ -504,7 +547,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 	rcu_assign_pointer(peer->sock, ovpn_sock);
 
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	ret = ovpn_nl_peer_modify(peer, info, attrs, remote);
 	if (ret < 0)
 		goto sock_release;
 
@@ -533,8 +576,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	const struct sockaddr_storage *remote = NULL;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
 	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct sockaddr_storage ss = {};
 	struct in6_addr vpn_addr6;
 	struct in_addr vpn_addr4;
 	struct ovpn_socket *sock;
@@ -568,17 +613,28 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOENT;
 	}
 
-	/* when using a TCP socket the remote IP is not expected */
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss))
+		remote = &ss;
+
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
-	if (sock && sock->sk->sk_protocol == IPPROTO_TCP &&
-	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
-	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
-		rcu_read_unlock();
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "unexpected remote IP address with TCP socket");
-		ovpn_peer_put(peer);
-		return -EINVAL;
+	if (sock && remote) {
+		if (sk_is_udp(sock->sk)) {
+			ret = ovpn_nl_udp_remote_compatible(sock->sk, remote,
+							    info->extack);
+			if (ret < 0) {
+				rcu_read_unlock();
+				ovpn_peer_put(peer);
+				return ret;
+			}
+		} else if (sk_is_tcp(sock->sk)) {
+			/* when using a TCP socket remote IP is not expected */
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "unexpected remote IP address with TCP socket");
+			rcu_read_unlock();
+			ovpn_peer_put(peer);
+			return -EINVAL;
+		}
 	}
 	rcu_read_unlock();
 
@@ -607,7 +663,7 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 			goto unlock;
 	}
 
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	ret = ovpn_nl_peer_modify(peer, info, attrs, remote);
 	if (ret < 0)
 		goto unlock;
 
